scriptName FightClub_Variables

GlobalVariable function CurrentFightId() global
    return Game.GetFormFromFile(0x807, "FightClub.esp") as GlobalVariable
endFunction

GlobalVariable function IsFightInProgress() global
    return Game.GetFormFromFile(0x808, "FightClub.esp") as GlobalVariable
endFunction

GlobalVariable function CurrentFightTeamCount() global
    return Game.GetFormFromFile(0x809, "FightClub.esp") as GlobalVariable
endFunction
