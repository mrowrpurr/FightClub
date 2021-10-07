scriptName FightClub_ConsoleHelper

string function RunConsoleCommand(string command) global
    ToggleConsole()
    Utility.WaitMenuMode(0.2)
    ClearConsoleText()
    Utility.WaitMenuMode(0.2)
    ConsoleUtil.ExecuteCommand(command)
    Utility.WaitMenuMode(0.2)
    string result = GetConsoleText()
    ToggleConsole()
    return result
endFunction

string function GetConsoleTextTarget() global
    return "_global.Console.ConsoleInstance.CommandHistory.text"
endFunction

function ClearConsoleText() global
    UI.SetString("Console", GetConsoleTextTarget(), "")
endFunction

string function GetConsoleText() global
    return UI.GetString("Console", GetConsoleTextTarget())
endFunction

function ToggleConsole() global
    Input.TapKey(Input.GetMappedKey("Console"))
endFunction
