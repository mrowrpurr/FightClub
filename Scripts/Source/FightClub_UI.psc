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
            JMap.setStr(team, "name", newName)
            Debug.MessageBox("Renamed " + oldName + " to " + newName)
            MainMenu(fightClubScript)
        else
            MainMenu(fightClubScript)
        endIf
    else
        MainMenu(fightClubScript)
    endIf
endFunction

function SpawnMonster(FightClub fightClubScript) global

endFunction

function ManageMonsters(FightClub fightClubScript) global

endFunction

function QuitFightClub(FightClub fightClubScript) global
endFunction

function SetMessageBoxText(FightClub fightClubScript, string text) global
    fightClubScript.FightClub_MessageText_BaseForm.SetName("~ Welcome to Fight Club ~\n\n" + text)
endFunction
