scriptName FightClub_UI
{Manages the UI for Fight Club}

function MainMenu(FightClub fightClubScript, Actor selectedMonster = None) global
    if fightClubScript.IsFightCurrentlyInProgress
        Debug.MessageBox("Stop match etc")
    elseIf fightClubScript.IsArrangingFightClubMatch
        ShowActivelyArrangingFightClubMatchMenu(fightClubScript)
    else
        FightClub_MainMenu(fightClubScript)
    endIf
endFunction

function FightClub_MainMenu(FightClub fightClubScript) global
    int beginArranging = 0
    SetMessageBoxText(fightClubScript, "")
    int result = fightClubScript.FightClub_MainMenu.Show()
    if result == beginArranging
        fightClubScript.BeginArrangingFightClubMatch()
    endIf
endFunction

function ShowActivelyArrangingFightClubMatchMenu(FightClub fightClubScript) global
    Actor selectedMonster = Game.GetCurrentCrosshairRef() as Actor
    if selectedMonster
        FightClub_MainMenu_WithMonster(fightClubScript, selectedMonster)    
    else
        FightClub_MainMenu_NoMonster(fightClubScript)
    endIf
endFunction

function FightClub_MainMenu_NoMonster(FightClub fightClubScript) global
    SetMessageBoxText(fightClubScript, "No monster selected")
    int fight = 0
    int spawnMonster = 1
    int manageMonsters = 2
    int renameTeam = 3
    int quit = 4
    int result = fightClubScript.FightClub_MainMenu_NoMonster.Show()
    if result == fight
    elseIf result == spawnMonster
        SpawnMonster(fightClubScript)
    elseIf result == manageMonsters
        ManageMonsters(fightClubScript)
    elseIf result == renameTeam
        RenameTeam(fightClubScript)
    elseIf result == quit
        QuitFightClub(fightClubScript)
    endIf
endFunction

function FightClub_MainMenu_WithMonster(FightClub fightClubScript, Actor monster) global
    SetMessageBoxText(fightClubScript, "The current monster selected is: " + monster.GetActorBase().GetName())
    int editMonster = 0
    int duplicateMonster = 1
    int fight = 2
    int spawnMonster = 3
    int manageMonsters = 4
    int renameTeam = 5
    int quit = 6
    int result = fightClubScript.FightClub_MainMenu_WithMonster.Show()
    if result == editMonster
    elseIf result == duplicateMonster
    elseIf result == fight
    elseIf result == spawnMonster
        SpawnMonster(fightClubScript)
    elseIf result == manageMonsters
        ManageMonsters(fightClubScript)
    elseIf result == renameTeam
        RenameTeam(fightClubScript)
    elseIf result == quit
        QuitFightClub(fightClubScript)
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

; TODO - Search!
function SpawnMonster(FightClub fightClubScript) global
    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    listMenu.AddEntryItem("[Search Monsters]")
    string[] monsterNames = fightClubScript.MonsterNames
    int i = 0
    while i < monsterNames.Length
        listMenu.AddEntryItem(monsterNames[i])
        i += 1
    endWhile
    listMenu.OpenMenu()
    int result = listMenu.GetResultInt()
    if result > -1
        UITextEntryMenu textEntry = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
        textEntry.SetPropertyString("text", "1")
        textEntry.OpenMenu()
        int numberOfMonsters = textEntry.GetResultString() as int
        if ! numberOfMonsters
            numberOfMonsters = 1
        endIf
        int monster = fightClubScript.GetMonsterByIndex(result - 1) ; -1 because of [Search...]
        Form monsterForm = JMap.getForm(monster, "form")

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
            Actor monsterInstance = fightClubScript.PlayerRef.PlaceAtMe(monsterForm, numberOfMonsters) as Actor
            fightClubScript.AddMonsterToTeam(monsterInstance, team)
        else
            MainMenu(fightClubScript)
        endIf
    else
        MainMenu(fightClubScript)
    endIf
endFunction

function AddMonster(FightClub fightClubScript) global
    string esp = ChooseESP()
    if esp
        UITextEntryMenu textEntry = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
        textEntry.SetPropertyString("text", "")
        textEntry.OpenMenu()

        string formId = textEntry.GetResultString()
        if formId
            Form monsterForm = Game.GetFormFromFile(FormHelper.HexToDecimal(formId), esp)
            if monsterForm
                ActorBase monster = monsterForm as ActorBase
                if monster
                    fightClubScript.AddMonster(monster)
                    Debug.MessageBox("Added monster " + monster.GetName())
                    ManageMonsters(fightClubScript)
                else
                    Debug.MessageBox("Form " + formId + " " + monsterForm.GetName() + " in " + esp + " is not an Actor")
                    MainMenu(fightClubScript)
                endIf
            else
                Debug.MessageBox("Could not find Form in " + esp + " with Form ID " + formId + "\n\nReminder: do not include the mod order prefix, e.g. FE003 or 04")
                MainMenu(fightClubScript)
            endIf
        else
            Debug.MessageBox("You did not enter a form ID")
            MainMenu(fightClubScript)
        endIf
    else
        Debug.MessageBox("You did not choose an ESP/ESM")
        MainMenu(fightClubScript)
    endIf
endFunction

string function ChooseESP() global
    UIListMenu listMenu = uiextensions.GetMenu("UIListMenu") as UIListMenu

    int numberOfMods = Game.GetModCount()
    int index = 0
    while index < numberOfMods
        string modName = Game.GetModName(index)
        listMenu.AddEntryItem(modName)
        index += 1
    endWhile

    int numberOfLightMods = Game.GetLightModCount()
    index = 0
    while index < numberOfLightMods
        string modName = Game.GetLightModName(index)
        listMenu.AddEntryItem(modName)
        index += 1
    endWhile

    listMenu.OpenMenu()

    int selectedIndex = listMenu.GetResultInt()
    if selectedIndex > -1
        if selectedIndex < numberOfMods
            return Game.GetModName(selectedIndex)
        else
            return Game.GetLightModName(selectedIndex - numberOfMods)
        endIf
    else
        return ""
    endIf
endFunction

function RenameMonster(FightClub fightClubScript) global
endFunction

function RemoveMonster(FightClub fightClubScript) global
endFunction

function ManageMonsters(FightClub fightClubScript) global
    int spawn = 0
    int add = 1
    int rename = 2
    int remove = 3
    int result = fightClubScript.FightClub_MainMenu_ManageMonsters.Show()
    if result == spawn
        SpawnMonster(fightClubScript)
    elseIf result == add
        AddMonster(fightClubScript)
    elseIf result == rename
        RenameMonster(fightClubScript)
    elseIf result == remove
        RemoveMonster(fightClubScript)
    else
        MainMenu(fightClubScript)
    endIf
endFunction

function QuitFightClub(FightClub fightClubScript) global
endFunction

function SetMessageBoxText(FightClub fightClubScript, string text) global
    fightClubScript.FightClub_MessageText_BaseForm.SetName("~ Welcome to Fight Club ~\n\n" + text)
endFunction
