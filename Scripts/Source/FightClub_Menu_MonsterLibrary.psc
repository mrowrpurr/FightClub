scriptName FightClub_Menu_MonsterLibrary

; TODO add one to View Monster to see its like stats and spawn it and whatever

Message function GetMessageBox() global
    return Game.GetFormFromFile(0x805, "FightClub.esp") as Message
endFunction

function Show() global
    int add = 0
    int view = 1
    int remove = 2
    int rename = 3
    int mainMenu = 4
    int result = GetMessageBox().Show()
    if result == add
        FightClub_Menu_MonsterLibrary_Add.Show()
    elseIf result == view
        ; TODO
    elseIf result == remove
        ; TODO
    elseIf result == rename
        FightClub_Menu_MonsterLibrary_Rename.Show()
    elseIf result == mainMenu
        FightClub_Menu_MainMenu.Show()
    else
        Debug.MessageBox("We dunno how to do that yet")
    endIf
endFunction
