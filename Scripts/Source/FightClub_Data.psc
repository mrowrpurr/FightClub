scriptName FightClub_Data

string function FightClubDataFile(string filename) global
    if filename
        return "Data/FightClub/Data/" + filename
    else
        return "Data/FightClub/Data"
    endIf
endFunction

int function GetContext(string contextName) global
endFunction

int function SaveContext(int context, string contextName) global
endFunction
