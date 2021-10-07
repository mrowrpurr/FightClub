scriptName FightClub_Menu_Fights

Message function GetMessageBox() global
    return Game.GetFormFromFile(0x801, "FightClub.esp") as Message
endFunction

function Show() global
    int firstOption = 0 ; Either Arrange or Start or Stop
    int mainMenu = 3
    int result = GetMessageBox().Show()
    if result == firstOption
        if FightClub_Fight.GetCurrentFight()
            if FightClub_Fight.IsFightInProgress()
                ; STOP FIGHT
            else
                ; START FIGHT
            endIf
        else
            FightClub_Menu_Fights_Arrange.Show()
        endIf
    elseIf result == mainMenu
        FightClub_Menu_MainMenu.Show()
    endIf
endFunction
