scriptName FightClub_Menu_TextEntry

string function GetUserText(string initialText = "") global
    UITextEntryMenu textEntry = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu
    if initialText
        textEntry.SetPropertyString("text", initialText)
    endIf
    textEntry.OpenMenu()
    return textEntry.GetResultString()
endFunction
