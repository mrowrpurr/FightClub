scriptName FightClub_Data

string function FightClubDataFile(string filename) global
    if filename
        return "Data/FightClub/Data/" + filename
    else
        return "Data/FightClub/Data"
    endIf
endFunction

int function InitializeContext(string contextName) global
    int context = JDB.solveObj(".fightClub." + contextName)
    if ! context
        context = JMap.object()
        JDB.solveObjSetter(".fightClub." + contextName, context, createMissingKeys = true)
    endIf
    return context
endFunction

int function GetContext(string contextName) global
    return InitializeContext(contextName)
endFunction

function SetContext(int context, string contextName) global
    JDB.solveObjSetter(".fightClub." + contextName, context, createMissingKeys = true)
endFunction

int function LoadContext(int context, string contextName) global
    int localContext = InitializeContext(contextName)
    int contextFromFile = JValue.readFromFile(FightClubDataFile(contextName))
    if contextFromFile
        SetContext(contextFromFile, contextName)
        return contextFromFile
    else
        return localContext
    endIf
endFunction

int function SaveContext(int context, string contextName) global
    JValue.writeToFile(context, FightClubDataFile(contextName))
endFunction
