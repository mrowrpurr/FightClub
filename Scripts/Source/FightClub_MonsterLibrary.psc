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

function RenameMonster(string oldName, string newName) global
    ActorBase monster = GetMonsterBaseByName(oldName)
    JMap.removeKey(LibraryData(), oldName)
    JMap.setForm(LibraryData(), newName, monster)
endFunction

ActorBase function GetMonsterBaseByName(string name) global
    return JMap.getForm(LibraryData(), name) as ActorBase
endFunction
