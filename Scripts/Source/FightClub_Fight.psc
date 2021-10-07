scriptName FightClub_Fight

int function GetCurrentFight() global
    return FightClub_Variables.CurrentFightId().Value as int
endFunction

bool function IsFightInProgress() global
    return FightClub_Variables.IsFightInProgress().Value == 1
endFunction

int function GetCurrentTeamCount() global
    return FightClub_Variables.CurrentFightTeamCount().Value as int
endFunction
