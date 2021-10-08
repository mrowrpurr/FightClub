scriptName FightClub_Team

string function ContextName() global
    return "teams"
endFunction

int function TeamsData() global
    return FightClub_Data.GetContext(ContextName())
endFunction

function SaveAll() global
    FightClub_Data.SaveContext(TeamsData(), ContextName())
endFunction

int function MaxTeamCount() global
    return 8
endFunction

string[] function AllTeamNames() global
    return JMap.allKeysPArray(TeamsData())
endFunction

int function GetTeamByName(string name) global
    return JMap.getObj(TeamsData(), name)
endFunction

int function Create(string name) global
    int team = JMap.object()
    SetName(team, name)
    AddTeam(team)
    return team
endFunction

int function CreateAndSave(string name) global
    Create(name)
    SaveAll()
endFunction

function AddTeam(int team) global
    JMap.setObj(TeamsData(), GetName(team), team)
endFunction

function SetName(int team, string name) global
    JMap.setStr(team, "name", name)
endFunction

string function GetName(int team) global
    return JMap.getStr(team, "name")
endFunction
