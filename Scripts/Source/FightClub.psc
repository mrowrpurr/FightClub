scriptName FightClub extends Quest
{Manages all of the monster data and everything for Fight Club}

; TODO - we should make a custom Nazeem
;        who uses magic and shouts with about 1000 health

; The number of teams available
int NumberOfTeamsAvailable = 8

int property Data
    int function get()
        int fightClubData = JDB.solveObj(".fightClub")
        if ! fightClubData
            fightClubData = JMap.object()
            JDB.solveObjSetter(".fightClub", fightClubData, createMissingKeys = true)
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

int property Teams
    int function get()
        return JMap.getObj(Data, "teams")
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

int property monsters
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

; Install the mod for the first time
event OnInit()
    ; Debug.MessageBox(PlayerRef.GetParentCell() + " " + PlayerRef.GetParentCell().GetName() + " " + PlayerRef.GetParentCell().GetFormID())
    Form hodForm = Game.GetForm(0x1347D)
    Form guarForm = Game.GetFormFromFile(0x5904, "mihailguar.esp")
    PlayerRef.EquipSpell(FightClub_MenuSpell, 0)
    PlayerRef.EquipSpell(FightClub_MenuSpell, 1)
    PlayerRef.PlaceAtMe(hodForm)
    PlayerRef.PlaceAtMe(guarForm)
endEvent

; Start arranging fight club match
function BeginArrangingFightClubMatch()
    IsArrangingFightClubMatch = true
    ConsoleUtil.ExecuteCommand("tgm")
    ConsoleUtil.ExecuteCommand("tcl")
    ConsoleUtil.ExecuteCommand("tcai")
    ConsoleUtil.ExecuteCommand("sucsm 5")
    PlayerRef.SetActorValue("speedmult", 350.0)
    Debug.MessageBox("Arranging Fight Match!")
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
endFunction
