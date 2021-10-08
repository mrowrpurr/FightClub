scriptName FightClub_Menu_Team

Message function GetMessageBox() global
    return Game.GetFormFromFile(0x80A, "FightClub.esp") as Message
endFunction

function Show(int team) global
    int addContestant = 0
    int removeContestant = 1
    int renameContestant = 2
    int renameAllContestants = 3
    int result = GetMessageBox().Show()
    if result == addContestant
        ; string monsterName = FightClub_Menu_ItemList.Choose(FightClub_MonsterLibrary.AllMonsterNames())
    elseIf result == removeContestant
        ;
    elseIf result == renameContestant
        ;
    elseIf result == renameAllContestants
        ;
    endIf
endFunction
