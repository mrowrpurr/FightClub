scriptName FightClub_UI
{Manages the UI for Fight Club}

function MainMenu(FightClub fightClubScript, Actor selectedMonster = None) global
    if fightClubScript.IsFightCurrentlyInProgress
        if fightClubScript.CurrentWinningTeam
            FightClub_Menu_PrepareForNextFight(fightClubScript)
        else
            FightClub_Menu_FightInProgress(fightClubScript)
        endIf
    elseIf fightClubScript.IsArrangingFightClubMatch
        FightClub_MainMenu_FightSetupMenu(fightClubScript)
    else
        FightClub_MainMenu(fightClubScript)
    endIf
endFunction

function FightClub_MainMenu(FightClub fightClubScript) global
    SetMessageBoxText(fightClubScript, "")
    int beginArranging = 0
    int monsterLibrary = 1
    int result = fightClubScript.FightClub_MainMenu.Show()
    if result == beginArranging
        fightClubScript.BeginArrangingFightClubMatch()
        MainMenu(fightClubScript)
    elseIf result == monsterLibrary
        ManageMonsters(fightClubScript)
    endIf
endFunction

function FightClub_MainMenu_FightSetupMenu(FightClub fightClubScript) global
    int fight = 0
    int spawnMonster = 1
    int manageMonsters = 2
    int renameTeam = 3
    int resetFight = 4
    int quit = 5
    int result = fightClubScript.FightClub_MainMenu_NoMonster.Show()
    if result == fight
        fightClubScript.BeginFight()
    elseIf result == resetFight
        fightClubScript.ResetAllTeams()
    elseIf result == spawnMonster
        SpawnMonster(fightClubScript)
    elseIf result == manageMonsters
        ManageMonsters(fightClubScript)
    elseIf result == renameTeam
        RenameTeam(fightClubScript)
    elseIf result == quit
    endIf
endFunction

function FightClub_Menu_PrepareForNextFight(FightClub fightClubScript) global
    int prepare = 0
    int resetAll = 1
    int result = fightClubScript.FightClub_Menu_PrepareForNextFight.Show()
    if result == prepare
        fightClubScript.PrepareForNextFight()
    elseIf result == resetAll
        fightClubScript.ResetAllTeams()
    endIf
endFunction

function FightClub_Menu_FightInProgress(FightClub fightClubScript) global
    int pause = 0
    int unpause = 1
    int resetAll = 2
    int result = fightClubScript.FightClub_Menu_FightInProgress.Show()
    if result == pause
        fightClubScript.PauseCombat()
    elseIf result == unpause
        fightClubScript.UnpauseCombat()
    elseIf result == resetAll
        fightClubScript.ResetAllTeams()
        fightClubScript.BeginArrangingFightClubMatch()
    endIf
endFunction

function RenameTeam(FightClub fightClubScript) global
    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    string[] teamNames = fightClubScript.TeamNames
    int i = 0
    while i < teamNames.Length
        listMenu.AddEntryItem(teamNames[i])
        i += 1
    endWhile
    listMenu.OpenMenu()
    int result = listMenu.GetResultInt()
    if result > -1
        UITextEntryMenu textEntry = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
        textEntry.OpenMenu()
        string newName = textEntry.GetResultString()
        if newName
            int team = fightClubScript.GetTeamByIndex(result)
            string oldName = JMap.getStr(team, "name")
            fightClubScript.RenameTeam(team, newName)
            Debug.MessageBox("Renamed " + oldName + " to " + newName)
            MainMenu(fightClubScript)
        else
            MainMenu(fightClubScript)
        endIf
    else
        MainMenu(fightClubScript)
    endIf
endFunction

function SpawnMonster(FightClub fightClubScript, string query = "") global
    int monsterList = JArray.object()
    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if ! query
        listMenu.AddEntryItem("[Search All Monsters]")
        listMenu.AddEntryItem("[Search Monster Library]")
    endIf
    string[] monsterNames = fightClubScript.MonsterNames
    int i = 0
    while i < monsterNames.Length
        string monsterName = monsterNames[i]
        if (! query) || (query && StringUtil.Find(monsterName, query) > -1)
            listMenu.AddEntryItem(monsterName)
            JArray.addStr(monsterList, monsterName)
        endIf
        i += 1
    endWhile

    listMenu.OpenMenu()
    int result = listMenu.GetResultInt()

    string[] monstersInList = JArray.asStringArray(monsterList)

    if result > -1
        if ! query && result == 1 ; Search
            UITextEntryMenu textEntry = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
            textEntry.OpenMenu()
            SpawnMonster(fightClubScript, query = textEntry.GetResultString())
            return
        else
            int offset = 2
            if query
                offset = 1
            endIf

            ; Get the selected monster
            ActorBase monsterForm
            string selectedMonsterName
            if result == 0 ; Search for the monster
                monsterForm = SearchForMonster()
                selectedMonsterName = monsterForm.GetName()
            else
                selectedMonsterName = monstersInList[result - offset]
                int monster = fightClubScript.GetMonsterByName(selectedMonsterName)
                monsterForm = JMap.getForm(monster, "form") as ActorBase
            endIf

            if ! monsterForm
                Debug.MessageBox("Could not get monster " + selectedMonsterName + "\n\nPlease try again! It will probably work.")
                return
            endIf

            ; Number of Monsters
            UITextEntryMenu textEntry = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
            textEntry.SetPropertyString("text", "1")
            textEntry.OpenMenu()
            int numberOfMonsters = textEntry.GetResultString() as int
            if ! numberOfMonsters
                numberOfMonsters = 1
            endIf

            ; Choose Team
            listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
            string[] teamNames = fightClubScript.TeamNames
            i = 0
            while i < teamNames.Length
                listMenu.AddEntryItem(teamNames[i])
                i += 1
            endWhile
            listMenu.OpenMenu()
            int selection = listMenu.GetResultInt()
            if selection > -1
                int team = fightClubScript.GetTeamByIndex(selection)
                i = 0
                while i < numberOfMonsters
                    Actor monsterInstance = fightClubScript.PlayerRef.PlaceAtMe(monsterForm) as Actor
                    if ! monsterInstance
                        Debug.MessageBox("Failed to place " + selectedMonsterName + " at player\n\nPlease try again. It will probably work.")
                        return
                    endIf
                    fightClubScript.AddMonsterToTeam(monsterInstance, team)
                    i += 1
                endWhile
            else
                MainMenu(fightClubScript)
            endIf
        endIf
    else
        MainMenu(fightClubScript)
    endIf
endFunction

function AddMonster(FightClub fightClubScript) global
    ActorBase monsterbase = SearchForMonster()
    Debug.MessageBox("Added " + monsterBase.GetName())
    fightClubScript.AddMonster(monsterBase)
endFunction

ActorBase function SearchForMonster() global
    string query = GetUserText()
    int results = ConsoleSearch.Search(query)
    int monsterCount = ConsoleSearch.GetResultCategoryCount(results, "NPC_")
    if ! monsterCount
        Debug.MessageBox("No monsters found matching " + query)
        return None
    endIf

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    int monsterFormsIds = JArray.object()

    int i = 0
    while i < monsterCount
        int monster = ConsoleSearch.GetNthResultInCategory(results, "NPC_", i)
        string name = ConsoleSearch.GetResultName(monster)
        string formId = ConsoleSearch.GetResultFormID(monster)
        ActorBase monsterBase = FormHelper.HexToForm(formId) as ActorBase
        if monsterBase
            JArray.addForm(monsterFormsIds, monsterBase)
            listMenu.AddEntryItem(name)
        endIf
        i += 1
    endWhile

    listMenu.OpenMenu()

    int result = listMenu.GetResultInt()

    if result > -1
        ActorBase monsterBase = JArray.getForm(monsterFormsIds, result) as ActorBase
        return monsterBase
    else
        return None
    endIf
endFunction

function ManageMonsters(FightClub fightClubScript) global
    int add = 0
    int rename = 1
    int remove = 2
    int result = fightClubScript.FightClub_MainMenu_ManageMonsters.Show()
    if result == add
        AddMonster(fightClubScript)
    elseIf result == rename
        RenameMonster(fightClubScript)        
    elseIf result == remove
        RemoveMonster(fightClubScript)
    else
        MainMenu(fightClubScript)
    endIf
endFunction

function RenameMonster(FightClub fightClubScript) global
    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    string[] monsterNames = fightClubScript.MonsterNames
    int i = 0
    while i < monsterNames.Length
        string monsterName = monsterNames[i]
        listMenu.AddEntryItem(monsterName)
        i += 1
    endWhile

    listMenu.OpenMenu()
    int result = listMenu.GetResultInt()

    if result > -1
        int monster = JArray.getObj(fightClubScript.Monsters, result)
        string name = JMap.getStr(monster, "name")
        string newName = GetUserText(name)
        if newName
            JMap.setStr(monster, "name", newName)
            Debug.MessageBox("Renamed " + name + "  to " + newName)
        endIf
    endIf

    ManageMonsters(fightClubScript)
endFunction

function RemoveMonster(FightClub fightClubScript) global
    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    string[] monsterNames = fightClubScript.MonsterNames
    int i = 0
    while i < monsterNames.Length
        string monsterName = monsterNames[i]
        listMenu.AddEntryItem(monsterName)
        i += 1
    endWhile

    listMenu.OpenMenu()
    int result = listMenu.GetResultInt()

    if result > -1
        int monster = JArray.getObj(fightClubScript.Monsters, result)
        string name = JMap.getStr(monster, "name")
        JArray.eraseObject(fightClubScript.Monsters, monster)
        Debug.MessageBox("Removed " + name)
    endIf

    ManageMonsters(fightClubScript)
endFunction

function SetMessageBoxText(FightClub fightClubScript, string text) global
    fightClubScript.FightClub_MessageText_BaseForm.SetName("~ Welcome to Fight Club ~\n\n" + text)
endFunction

string function GetUserText(string defaultText = "") global
    UITextEntryMenu textEntry = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
    if defaultText
        textEntry.SetPropertyString("text", defaultText)
    endIf
    textEntry.OpenMenu()
    return textEntry.GetResultString()
endFunction
