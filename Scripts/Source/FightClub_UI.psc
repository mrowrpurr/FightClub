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
    SetMessageBoxText(fightClubScript, "~ Welcome to Fight Club ~")
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
    int manageTeams = 3
    int quitFightClub = 4
    int result = fightClubScript.FightClub_MainMenu_NoMonster.Show()
    if result == fight
    elseIf result == spawnMonster
    elseIf result == manageMonsters
    elseIf result == manageTeams
    elseIf result == quitFightClub
    endIf
endFunction

function FightClub_MainMenu_WithMonster(FightClub fightClubScript, Actor monster) global
    SetMessageBoxText(fightClubScript, "The current monster selected is: " + monster.GetActorBase().GetName())
    int editMonster = 0
    int duplicateMonster = 1
    int fight = 2
    int spawnMonster = 3
    int manageMonsters = 4
    int manageTeams = 5
    int quitFightClub = 6
    int result = fightClubScript.FightClub_MainMenu_WithMonster.Show()
    if result == editMonster
    elseIf result == duplicateMonster
    elseIf result == fight
    elseIf result == spawnMonster
    elseIf result == manageMonsters
    elseIf result == manageTeams
    elseIf result == quitFightClub
    endIf
endFunction

function SetMessageBoxText(FightClub fightClubScript, string text) global
    fightClubScript.FightClub_MessageText_BaseForm.SetName(text)
endFunction
