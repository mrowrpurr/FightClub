scriptName FightClub_PlayerScript extends ReferenceAlias  

; On Mod Installation
event OnInit()
    Spell theSpell = Game.GetFormFromFile(0x800, "FightClub.esp") as Spell
    GetActorReference().EquipSpell(theSpell, 0)
    GetActorReference().EquipSpell(theSpell, 1)
    Initialize()
endEvent

; On Save Game Load
event OnPlayerLoadGame()
    Initialize()
endEvent

function Initialize()
    FightClub_Data.LoadAll()
endFunction
