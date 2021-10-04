scriptName FightClub_OpenMenu extends ActiveMagicEffect  

FightClub property FightClubScript auto

event OnEffectStart(Actor target, Actor caster)
    FightClub_UI.MainMenu(FightClubScript)
endEvent
