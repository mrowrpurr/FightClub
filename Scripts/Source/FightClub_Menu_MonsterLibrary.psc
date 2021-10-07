scriptName FightClub_Menu_MonsterLibrary

Message function GetMessageBox() global
    return Game.GetFormFromFile(0x805, "FightClub.esp") as Message
endFunction

function Show() global
    int add = 0
    int remove = 1
    int rename = 2
    int mainMenu = 3
    int result = GetMessageBox().Show()
    if result == add
        FightClub_Menu_MonsterLibrary_Add.Show()
    elseIf result == remove

    elseIf result == rename

    elseIf result == mainMenu
        FightClub_Menu_MainMenu.Show()
    else
        Debug.MessageBox("We dunno how to do that yet")
    endIf
endFunction
