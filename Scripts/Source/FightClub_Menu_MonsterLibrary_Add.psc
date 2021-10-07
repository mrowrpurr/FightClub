scriptName FightClub_Menu_MonsterLibrary_Add

function Show() global
    string esp = FightClub_Menu_ModChooser.ChooseMod()
    if esp
        string formIdHex = FightClub_Menu_TextEntry.GetUserText()
        if formIdHex
            int formId = FormHelper.HexToDecimal(formIdHex)
            ActorBase monsterBase = Game.GetFormFromFile(formId, esp) as ActorBase
            if monsterBase
                string monsterName = FightClub_Menu_TextEntry.GetUserText(monsterBase.GetName())
                if monsterName
                    FightClub_MonsterLibrary.AddFromMod(monsterBase, monsterName)
                    FightClub_MonsterLibrary.Save()
                    Debug.MessageBox("Added " + monsterName)
                    FightClub_Menu_MonsterLibrary.Show()
                else
                    FightClub_Menu_MonsterLibrary.Show()
                endIf
            else
                Debug.MessageBox("Form ID " + formIdHex + " from " + esp + " was not a valid ActorBase")
                FightClub_Menu_MonsterLibrary.Show()
            endIf
        else
            FightClub_Menu_MonsterLibrary.Show()
        endIf
    else
        FightClub_Menu_MonsterLibrary.Show()
    endIf
endFunction

; TODO - Search Console for NPCs

; function Show_ConsoleVersion_WIP() global
;     string monsterQuery = FightClub_Menu_TextEntry.GetUserText()
;     string consoleResult = FightClub_ConsoleHelper.RunConsoleCommand("help \"" + monsterQuery + "\"")
;     ; Form[] monsterForms = FightClub_ConsoleHelper.GetNpcsFromConsoleText(consoleResult)
;     ; Debug.MessageBox(monsterForms)
; endFunction