scriptName FightClub_Menu_MainMenu

Message function GetMessageBox() global
    return Game.GetFormFromFile(0x802, "FightClub.esp") as Message
endFunction

function Show() global
    FightClub_Menu.SetDefaultMessageText()
    int fights = 0
    int contestants = 1
    int teams = 2
    int locations = 3
    int monsterLibrary = 4
    int result = GetMessageBox().Show()
    if result == fights
        Debug.MessageBox("Sweet, let's organize us some fights")
    elseIf result == contestants
    elseIf result == teams
    elseIf result == locations
    elseIf result == monsterLibrary
        FightClub_Menu_MonsterLibrary.Show()
    else
        Debug.MessageBox("We dunno how to do that yet")
    endIf
endFunction
