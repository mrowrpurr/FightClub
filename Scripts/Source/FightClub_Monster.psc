scriptName FightClub_Monster
{Represents a monster}

; int function AddMonster(ActorBase )

int function Create(string name, ActorBase monsterBase) global
    int monster = JMap.object()
    SetName(monster, name)
    SetActorBase(monster, monsterBase)
    return monster
endFunction

; REMOVE THIS
function SetName(int monster, string name) global
    JMap.setStr(monster, "name", name)
endFunction

; REMOVE THIS
string function GetName(int monster) global
    return JMap.getStr(monster, "name")
endFunction

; REMOVE THIS
function SetActorBase(int monster, ActorBase monsterBase) global
    JMap.setForm(monster, "form", monsterBase)
endFunction

; REMOVE THIS
ActorBase function GetActorBase(int monster) global
    return JMap.getForm(monster, "form") as ActorBase
endFunction
