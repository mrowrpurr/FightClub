scriptName FightClub extends Quest
{Manages all of the monster data and everything for Fight Club}

bool property IsArrangingFightClubMatch  auto
bool property IsFightCurrentlyInProgress auto

; Main Spell for Fight Club
Spell property FightClub_MenuSpell auto

; Messages
Message Property FightClub_MainMenu             auto
Message property FightClub_MainMenu_NoMonster   auto
Message property FightClub_MainMenu_WithMonster auto

; Used to set Message text
; See `FightClub_UI.SetMessageBoxText()`
Form property FightClub_MessageText_BaseForm auto

; Factions representing different teams
Faction property FightClub_Team1 auto
Faction property FightClub_Team2 auto
Faction property FightClub_Team3 auto
Faction property FightClub_Team4 auto
Faction property FightClub_Team5 auto
Faction property FightClub_Team6 auto
Faction property FightClub_Team7 auto
Faction property FightClub_Team8 auto

; ADD FACTIONS

event OnInit()
    ; Toggle Collision
    ; Increase Player Speed

    Form hodForm = Game.GetForm(0x1347D)
    Form guarForm = Game.GetFormFromFile(0x5904, "mihailguar.esp")

    PlayerRef.EquipSpell(FightClub_MenuSpell, 0)
    PlayerRef.EquipSpell(FightClub_MenuSpell, 1)
    PlayerRef.PlaceAtMe(hodForm)
    PlayerRef.PlaceAtMe(guarForm)
endEvent

function BeginArrangingFightClubMatch()
    IsArrangingFightClubMatch = true
    ConsoleUtil.ExecuteCommand("tgm")
    ConsoleUtil.ExecuteCommand("tcl")
    ConsoleUtil.ExecuteCommand("tcai")
    ConsoleUtil.ExecuteCommand("sucsm 5")
    PlayerRef.SetActorValue("speedmult", 350.0)
    Debug.Notification("Arranging Fight Match...")
endFunction


; int GUAR_ONE = 0x5904
; int GUAR_TWO = 0x23fa4
; int GUAR_THREE = 0x1ee12
; int GUAR_FOUR = 0x1ee15
; int GUAR_FIVE = 0x1ee1

Actor Property PlayerRef  Auto  
