scriptName FightClub extends Quest
{Manages all of the monster data and everything for Fight Club}

; TODO - we should make a custom Nazeem
;        who uses magic and shouts with about 1000 health

; The number of teams available
int NumberOfTeamsAvailable = 8

bool _loadedFromConfigFile = false
string property FIGHT_CLUB_CONFIG_FILE = "Data/FightClub/Config.json" autoReadonly

; Keep Track of How Many Times the Given Team has won!

; Also be able to reset the whole team's health and resurrect them

; ; STOP or PAUSE
; 3. Cleanup.
; RESET and do another match
; 4. Player Load Games
; 5. Nexus!
; 6. Player Bet using Gold

; TODO - Separate Team and Monster configs into separate files

int property BattleData
    int function get()
        int battleDataId = JDB.solveObj(".fightClub.battleDataId")
        if ! battleDataId
            battleDataId = JMap.object()
            JDB.solveObjSetter(".fightClub.battleDataId", battleDataId, createMissingKeys = true)
            JMap.setObj(battleDataId, "monstersToTeams", JFormMap.object())
            int aliveMonsterTeams = JIntMap.object()
            JMap.setObj(battleDataId, "aliveMonstersPerTeam", aliveMonsterTeams)
            int[] theTeamIds = TeamIds
            int i = 0
            while i < theTeamIds.Length
                JIntMap.setObj(aliveMonsterTeams, theTeamIds[i], JArray.object())
                i += 1
            endWhile
        endIf
        return battleDataId
    endFunction
endProperty

int property Data
    int function get()
        ; [TODO] Have this reload for save games
        if ! _loadedFromConfigFile
            _loadedFromConfigFile = true
            ; Load from disk, if available
            int fightClubData = JValue.readFromFile(FIGHT_CLUB_CONFIG_FILE)
            if fightClubData
                JDB.solveObjSetter(".fightClub.config", fightClubData, createMissingKeys = true)
                return fightClubData
            endIf
        endIf

        int fightClubData = JDB.solveObj(".fightClub.config")
        if ! fightClubData
            fightClubData = JMap.object()
            JDB.solveObjSetter(".fightClub.config", fightClubData, createMissingKeys = true)
            JMap.setObj(fightClubData, "monsters", JArray.object())
            int theTeams = JArray.object()
            JMap.setObj(fightClubData, "teams", theTeams)
            int i = 0
            while i < NumberOfTeamsAvailable
                int team = JMap.object()
                JArray.addObj(theTeams, team)
                JMap.setStr(team, "name", "Team " + (i + 1))
                JMap.setObj(team, "monsters", JArray.object())
                i += 1
            endWhile
        endIf
        return fightClubData
    endFunction
endProperty

int property MonstersToTeams
    int function get()
        return JMap.getObj(BattleData, "monstersToTeams")
    endFunction
endProperty

int property AliveMonstersPerTeam
    int function get()
        return JMap.getObj(BattleData, "aliveMonstersPerTeam")
    endFunction
endProperty

int property Teams
    int function get()
        return JMap.getObj(Data, "teams")
    endFunction
endProperty

int[] property TeamIds
    int[] function get()
        int theTeams = Teams
        int teamCount = JArray.count(theTeams)
        int[] theTeamIds = Utility.CreateIntArray(teamCount)
        int i = 0
        while i < teamCount
            theTeamIds[i] = JArray.getObj(theTeams, i)
            i += 1
        endWhile
        return theTeamIds
    endFunction
endProperty

string[] property TeamNames
    string[] function get()
        string[] names = new string[8]
        int theTeams = Teams
        int i = 0
        while i < NumberOfTeamsAvailable
            names[i] = JMap.getStr(JArray.getObj(theTeams, i), "name")
            i += 1
        endWhile
        return names
    endFunction
endProperty

int function GetMonstersForTeam(int team)
    return JMap.getObj(team, "monsters")
endFunction

Form[] function GetMonsterInstancesForTeam(int team)
    int theMonster = GetMonstersForTeam(team)
    int monsterCount = JArray.count(theMonster)
    Form[] monsterInstances = Utility.CreateFormArray(monsterCount)
    int i = 0
    while i < monsterCount
        monsterInstances[i] = JArray.getForm(theMonster, i)
        i += 1
    endWhile
    return monsterInstances
endFunction

int function GetAliveMonstersForTeam(int team)
    return JIntMap.getObj(AliveMonstersPerTeam, team)
endFunction

string[] property MonsterNames
    string[] function get()
        int theMonsters = Monsters
        int monsterCount = JArray.count(theMonsters)
        string[] names = Utility.CreateStringArray(monsterCount)
        int i = 0
        while i < monsterCount
            names[i] = JMap.getStr(JArray.getObj(theMonsters, i), "name")
            i += 1
        endWhile
        return names
    endFunction
endProperty

int property Monsters
    int function get()
        return JMap.getObj(Data, "monsters")
    endFunction
endProperty

; The current state which Fight Club is in
bool property IsArrangingFightClubMatch  auto
bool property IsFightCurrentlyInProgress auto

; Player
Actor property PlayerRef auto

; Main Spell for Fight Club
Spell property FightClub_MenuSpell auto

; Messages
Message property FightClub_MainMenu                auto
Message property FightClub_MainMenu_NoMonster      auto
Message property FightClub_MainMenu_WithMonster    auto
Message property FightClub_MainMenu_ManageMonsters auto

; Used to set Message text
; See `FightClub_UI.SetMessageBoxText()`
Form property FightClub_MessageText_BaseForm auto

; Factions representing different teams
Faction property FightClub_Team1 auto
Faction property FightClub_Team2 auto
Faction property FightClub_Team3 auto
Faction property FightClub_Team4 auto
Faction property FightClub_Team5 auto
Faction property FightClub_Team6 auto
Faction property FightClub_Team7 auto
Faction property FightClub_Team8 auto

; The spell/ability which is added to all contestants
Spell property FightClub_ContestantSpell auto

; Install the mod for the first time
event OnInit()
    PlayerRef.EquipSpell(FightClub_MenuSpell, 0)
    PlayerRef.EquipSpell(FightClub_MenuSpell, 1)
endEvent

; Start arranging fight club match
function BeginArrangingFightClubMatch()
    IsArrangingFightClubMatch = true
    ConsoleUtil.ExecuteCommand("tgm")
    ConsoleUtil.ExecuteCommand("tcl")
    ConsoleUtil.ExecuteCommand("tcai")
    ConsoleUtil.ExecuteCommand("sucsm 10")
    PlayerRef.SetActorValue("speedmult", 350.0)
endFunction

int function GetTeamByIndex(int index)
    return JArray.getObj(Teams, index)
endFunction

int function GetMonsterByIndex(int index)
    return JArray.getObj(Monsters, index)
endFunction

int function AddMonster(ActorBase monster)
    int monsterMap = JMap.object()
    JArray.addObj(Monsters, monsterMap)
    JMap.setForm(monsterMap, "form", monster)
    string name = monster.GetName()
    if ! name
        name = monster.GetName()
    endIf
    JMap.setStr(monsterMap, "name", name)
    Save()
    return monsterMap
endFunction

function RenameTeam(int team, string newName)
    JMap.setStr(team, "name", newName)
    Save()
endFunction

function AddMonsterToTeam(Actor monster, int team)
    ; Remove monster from all existing Factions
    monster.RemoveFromAllFactions()

    ; Make them Aggressive. Attack Enemies on sight. Do not attack Neutrals or everyone.
    monster.SetActorValue("Aggression", 2)

    ; Make them Foolhardy; Will never avoid/flee from anyone. 
    monster.SetActorValue("Confidence", 4)

    ; Make them Help Allies. Will not Help Friends who are not Allies.
    monster.SetActorValue("Assistance", 1)

    ; Add our custom ability for contestants
    monster.AddSpell(FightClub_ContestantSpell)

    ; Track this SPECIFIC monster and which team they're on
    JFormMap.setObj(MonstersToTeams, monster, team)

    JArray.addForm(GetAliveMonstersForTeam(team), monster)

    int teamMonsters = GetMonstersForTeam(team)
    JArray.addForm(teamMonsters, monster)
    Faction teamFaction = GetFactionForTeam(team)
    Faction[] factions = AllFactions()
    int i = 0
    while i < factions.Length
        Faction thisFaction = factions[i]
        if thisFaction == teamFaction
            monster.AddToFaction(thisFaction)
            monster.SetFactionRank(thisFaction, 3)
        else
            monster.RemoveFromFaction(thisFaction)
        endIF
        i += 1
    endWhile

    JValue.writeToFile(BattleData, "BattleData.json")
endFunction

int function GetTeamForMonster(Actor monster)
    return JFormMap.getObj(MonstersToTeams, monster)
endFunction

Faction[] function AllFactions()
    Faction[] factions = new Faction[8]
    factions[0] = FightClub_Team1
    factions[1] = FightClub_Team2
    factions[2] = FightClub_Team3
    factions[3] = FightClub_Team4
    factions[4] = FightClub_Team5
    factions[5] = FightClub_Team6
    factions[6] = FightClub_Team7
    factions[7] = FightClub_Team8
    return factions
endFunction

Faction function GetFactionForTeam(int team)
    int teamIndex = JArray.findObj(Teams, team)
    Faction[] factions = AllFactions()
    return factions[teamIndex]
endFunction

; This saves the configuration to disk!
function Save()
    JValue.writeToFile(Data, FIGHT_CLUB_CONFIG_FILE)
endFunction

function BeginFight()
    MakeEveryoneOnEachTeamFriendsWithOneAnother()
    ConsoleUtil.ExecuteCommand("tcl")
    ConsoleUtil.ExecuteCommand("tcai")
endFunction

function MakeEveryoneOnEachTeamFriendsWithOneAnother()
    int theTeams = Teams
    int teamCount = JArray.count(theTeams)
    int teamIndex = 0
    while teamIndex < teamCount
        int team = JArray.getObj(theTeams, teamIndex)
        Form[] teamMonsters = GetMonsterInstancesForTeam(team)
        int monsterOuterIndex = 0
        while monsterOuterIndex < teamMonsters.Length
            int monsterInnerIndex = 0
            while monsterInnerIndex < teamMonsters.Length
                Actor monsterA = teamMonsters[monsterOuterIndex] as Actor
                Actor monsterB = teamMonsters[monsterInnerIndex] as Actor
                if monsterA != monsterB
                    monsterA.SetRelationshipRank(monsterB, 4)
                    monsterB.SetRelationshipRank(monsterA, 4)
                endIf
                monsterInnerIndex += 1
            endWhile
            monsterOuterIndex += 1
        endWhile
        teamIndex += 1
    endWhile
endFunction

string function GetTeamName(int team)
    return JMap.getStr(team, "name")
endFunction

string function GetMonsterName(Actor monster)
    string name = monster.GetName()
    if name
        return name
    else
        return monster.GetActorBase().GetName()
    endIf
endFunction

function TrackDeath(Actor target, Actor killer)
    int targetTeam = GetTeamForMonster(target)
    int aliveMonstersOnTeam = GetAliveMonstersForTeam(targetTeam)
    JArray.eraseForm(aliveMonstersOnTeam, target)
    int winningTeam = GetWinningTeam()
    if winningTeam
       MatchIsWon(winningTeam) 
    endIf
endFunction

function MatchIsWon(int winningTeam)
    PauseCombat()
    Debug.MessageBox(GetTeamName(winningTeam) + " is victorious!")
endFunction

function PauseCombat()
    ConsoleUtil.ExecuteCommand("tcai")
endFunction

function TrackHit(Actor target, Actor attacker, Form weaponOrSpell)
    ; TODO
endFunction

int function GetWinningTeam()
    int remainingTeams = JArray.object()
    int[] theTeamIds = TeamIds
    int i = 0
    while i < theTeamIds.Length
        int remainingTeamMembers = GetAliveMonstersForTeam(theTeamIds[i])
        if JArray.count(remainingTeamMembers) > 0
            JArray.addObj(remainingTeams, theTeamIds[i])
        endIf
        i += 1
    endWhile
    int remainingTeamCount = JArray.count(remainingTeams)
    if remainingTeamCount == 1
        return JArray.getObj(remainingTeams, 0)
    else
        return 0
    endIf
endFunction
