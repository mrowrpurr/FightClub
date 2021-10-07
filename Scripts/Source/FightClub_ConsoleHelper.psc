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

; Look for lines like:
; NPC_: (0001234) 'Name'
; Form[] function GetNpcsFromConsoleText(string text) global
;     Form[] npcs

;     string searchPrefix = "NPC_: (" 
;     int searchPrefixLength = StringUtil.GetLength(searchPrefix)
;     int characterIndex = 0

;     bool readingNpc = false
;     bool readingNpcFormId = false
;     bool readingNpcName = false
;     string npcFormId = ""
;     string npcName = ""

;     int textLength = StringUtil.GetLength(text)
;     while characterIndex < textLength
;         string character = StringUtil.GetNthChar(text, characterIndex)
;         if readingNpcName && character = "'"
;             ; DONE READING NPC!
;             if npcs
;                 npcs = Utility.ResizeFormArray(npcs, npcs.Length + 1)
;                 npcs[npcs.Length - 1] = GetActorBaseFromFormId()
;             else

;             endIf
;         endIf

;         if StringUtil.Substring(text, characterIndex, searchPrefixLength) == searchPrefix
;             ; if currentNpcText
                
;             ; else
                
;             ; endIf
;         endIf
;         characterIndex += 1
;     endWhile

;     ; DONE READING NPC!
; endFunction

; ActorBase function GetActorBaseFromFormId(string formId)

; endFunction
