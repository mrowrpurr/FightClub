scriptName FightClub_Menu_ItemList

string function Choose(string[] items, string query = "", bool search = true) global
    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    Debug.MessageBox("Choose [items] Query: '" + query + "'")

    bool showSearchItem = search && ! query

    if showSearchItem
        listMenu.AddEntryItem("[Search]")
    endIf

    int i = 0
    while i < items.Length
        listMenu.AddEntryItem(items[i])
        i += 1
    endWhile
    
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
