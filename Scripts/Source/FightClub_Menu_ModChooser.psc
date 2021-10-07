scriptName FightClub_Menu_ModChooser

string function ChooseMod() global
    int modNames = JArray.object()

    int numberOfMods = Game.GetModCount()
    int index = 0
    while index < numberOfMods
        string modName = Game.GetModName(index)
        JArray.addStr(modNames, modName)
        index += 1
    endWhile

    int numberOfLightMods = Game.GetLightModCount()
    index = 0
    while index < numberOfLightMods
        string modName = Game.GetLightModName(index)
        JArray.addStr(modNames, modName)
        index += 1
    endWhile

    return FightClub_Menu_ItemList.Choose(JArray.asStringArray(modNames))
endFunction
