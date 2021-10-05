scriptName FightClub_Contestant extends ActiveMagicEffect  

FightClub property FightClubScript auto

Actor TargetActor

event OnEffectStart(Actor target, Actor caster)
  TargetActor = target
endEvent

event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)
    FightClubScript.TrackHit(TargetActor, akAggressor as Actor, akSource)
endEvent

event OnDying(Actor akKiller)
  FightClubScript.TrackDeath(TargetActor, akKiller)
endEvent
