scriptName FightClub_Menu_Fights_Arrange

Message function GetMessageBox() global
    return Game.GetFormFromFile(0x806, "FightClub.esp") as Message
endFunction

function Show() global
    int addTeam = 0
    int viewTeam = 1
    int removeTeam = 2
    int renameTeam = 3
    int back = 4
    int result = GetMessageBox().Show()
    if result == addTeam
        string teamName = FightClub_Menu_TextEntry.GetUserText()
        if teamName
            FightClub_Team.CreateAndSave(teamName)
            Debug.MessageBox("Created team " + teamName)
            Show()
        else
            Show()
        endIf
    elseIf result == viewTeam
        Debug.MessageBox(FightClub_Team.AllTeamNames())
    elseIf result == removeTeam

    elseIf result == renameTeam

    elseIf result == back
        FightClub_Menu_Fights.Show()
    endIf
endFunction
