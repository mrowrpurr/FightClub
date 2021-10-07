scriptName FightClub_Menu_MonsterLibrary_Rename

function Show() global
    string monsterName = FightClub_Menu_ItemList.Choose(FightClub_MonsterLibrary.AllMonsterNames())
    if monsterName
        string newName = FightClub_Menu_TextEntry.GetUserText(monsterName)
        FightClub_MonsterLibrary.RenameMonster(monsterName, newName)
        FightClub_MonsterLibrary.Save()
        Debug.MessageBox("Renamed to " + newName)
        FightClub_Menu_MonsterLibrary.Show()
    else
        FightClub_Menu_MonsterLibrary.Show()
    endIf
endFunction
