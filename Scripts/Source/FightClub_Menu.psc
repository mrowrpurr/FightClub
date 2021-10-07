scriptName FightClub_Menu

Form function MessageText() global
    return Game.GetFormFromFile(0x803, "FightClub.esp")
endFunction

string function HeaderText() global
    return "~ Welcome to Fight Club ~"
endFunction

function SetMessageText(string text) global
    MessageText().SetName(HeaderText() + "\n\n" + text)
endFunction

function SetDefaultMessageText() global
    MessageText().SetName(HeaderText())
endFunction
