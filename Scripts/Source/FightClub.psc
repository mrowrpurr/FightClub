scriptName FightClub extends Quest  

FightClub function GetInstance() global
    return Game.GetFormFromFile(0xd65, "FightClub.esp") as FightClub
endFunction
