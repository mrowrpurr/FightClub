scriptName FightClub_Monster
{Represents a monster}

; int function AddMonster(ActorBase )

int function Create(string name, ActorBase monsterBase) global
    int monster = JMap.object()
    SetName(monster, name)
    SetActorBase(monster, monsterBase)
    return monster
endFunction

function SetName(int monster, string name) global
    JMap.setStr(monster, "name", name)
endFunction

function SetActorBase(int monster, ActorBase monsterBase) global
    JMap.setForm(monster, "form", monsterBase)
endFunction
