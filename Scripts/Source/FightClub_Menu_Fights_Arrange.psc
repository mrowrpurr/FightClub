scriptName FightClub_Menu_Fights_Arrange

Message function GetMessageBox() global
    return Game.GetFormFromFile(0x806, "FightClub.esp") as Message
endFunction

function Show() global
    int addTeam = 0
    int selectTeam = 1
    int viewTeam = 2
    int removeTeam = 3
    int renameTeam = 4
    int back = 5
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
    elseIf result == selectTeam
        string teamName = FightClub_Menu_ItemList.Choose(FightClub_Team.AllTeamNames())
        int team = FightClub_Team.GetTeamByName(teamName)
        FightClub_Menu_Team.Show(team)
    elseIf result == viewTeam
        Debug.MessageBox(FightClub_Team.AllTeamNames())
    elseIf result == removeTeam

    elseIf result == renameTeam

    elseIf result == back
        FightClub_Menu_Fights.Show()
    endIf
endFunction
