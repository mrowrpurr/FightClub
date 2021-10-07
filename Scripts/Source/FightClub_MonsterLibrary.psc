scriptName FightClub_MonsterLibrary

int function LibraryData() global
    return FightClub_Data.GetContext("monsters")
endFunction

ActorBase function AddFromMod(ActorBase monsterBase, string name) global
    int monster = FightClub_Monster.Create(name, monsterBase)
    AddMonster(monster)
    JValue.writeToFile(LibraryData(), "FightClub_Monsters.json")
    JValue.writeToFile(JDB.solveObj(".fightClub"), "FightClub_All.json")
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
