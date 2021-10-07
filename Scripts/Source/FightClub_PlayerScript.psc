scriptName FightClub_PlayerScript extends ReferenceAlias  

event OnInit()
    Spell theSpell = Game.GetFormFromFile(0x800, "FightClub.esp") as Spell
    GetActorReference().EquipSpell(theSpell, 0)
    GetActorReference().EquipSpell(theSpell, 1)
endEvent
