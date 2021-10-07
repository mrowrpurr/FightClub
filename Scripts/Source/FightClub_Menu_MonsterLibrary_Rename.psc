scriptName FightClub_Menu_MonsterLibrary_Rename

function Show() global
    string monsterName = FightClub_Menu_ItemList.Choose(FightClub_MonsterLibrary.AllMonsterNames())
    Debug.MessageBox("You want to rename monster " + monsterName + ", right?")
endFunction
