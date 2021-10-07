scriptName FightClub_Menu_ItemList

string function Choose(string[] items, string query = "", bool search = true) global
    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    int queryMatchItems = JArray.object()

    bool showSearchItem = search && ! query

    if showSearchItem
        listMenu.AddEntryItem("[Search]")
    endIf

    int i = 0
    while i < items.Length
        string item = items[i]
        if (! query) || (query && StringUtil.Find(item, query) > -1)
            listMenu.AddEntryItem(items[i])
            if query
                JArray.addStr(queryMatchItems, item)
            endIf
        endIf
        i += 1
    endWhile

    if query
        items = JArray.asStringArray(queryMatchItems)
    endIf

    listMenu.OpenMenu()

    int selectedIndex = listMenu.GetResultInt()

    if showSearchItem
        if selectedIndex == 0
            return Choose(items, query = FightClub_Menu_TextEntry.GetUserText())
        else
            return items[selectedindex - 1]
        endIf
    else
        return items[selectedindex]
    endIf
endFunction
