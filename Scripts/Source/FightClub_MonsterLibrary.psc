scriptName FightClub_MonsterLibrary

int function LibraryData() global
    return FightClub_Data.GetContext("monsters")
endFunction

ActorBase function AddFromMod(ActorBase monsterBase, string name) global
    int monster = FightClub_Monster.Create(name, monsterBase)
    AddMonster(monster)
endFunction

function AddMonster(int monster) global
    JArray.addObj(LibraryData(), monster)
endFunction

int function GetMonsterCount() global
    return JArray.count(LibraryData())
endFunction

string[] function AllMonsterNames() global
    int monsterNames = JArray.object()
    int monsterCount = GetMonsterCount()
    int i = 0
    while i < monsterCount
        JArray.addObj(monsterNames, JArray.getObj(LibraryData(), i))
        i += 1
    endWhile
    return JArray.asStringArray(monsterNames)
endFunction
