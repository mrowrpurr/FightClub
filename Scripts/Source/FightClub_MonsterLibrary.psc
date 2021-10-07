scriptName FightClub_MonsterLibrary

string function ContextName() global
    return "monsters"
endFunction

int function LibraryData() global
    return FightClub_Data.GetContext(ContextName())
endFunction

function Save() global
    FightClub_Data.SaveContext(LibraryData(), ContextName())
endFunction

ActorBase function AddFromMod(ActorBase monsterBase, string name) global
    int monster = FightClub_Monster.Create(name, monsterBase)
    AddMonster(monster)
endFunction

function AddMonster(int monster) global
    JMap.setForm(LibraryData(), \
        FightClub_Monster.GetName(monster), \
        FightClub_Monster.GetActorBase(monster))
endFunction

int function GetMonsterCount() global
    return JMap.count(LibraryData())
endFunction

string[] function AllMonsterNames() global
    return JMap.allKeysPArray(LibraryData())
endFunction

int function GetMonsterByName(string name) global
    return JMap.getObj(LibraryData(), name)
endFunction
