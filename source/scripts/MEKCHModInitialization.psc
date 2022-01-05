Scriptname MEKCHModInitialization extends ReferenceAlias 

Weapon Property MEKCHWeapIronChairhammer Auto
Weapon Property MEKCHWeapSteelChairhammer Auto
Weapon Property MEKCHWeapOrcishChairhammer Auto
Weapon Property MEKCHWeapDwarvenChairhammer Auto
Weapon Property MEKCHWeapElvenChairhammer Auto
Weapon Property MEKCHWeapGlassChairhammer Auto
Weapon Property MEKCHWeapEbonyChairhammer Auto
Weapon Property MEKCHWeapDaedricChairhammer Auto
Weapon Property DaedricWarhammer Auto


LeveledItem Property LItemWeaponDwarvenWarhammer Auto
LeveledItem Property LItemwerewolfBossWarhammer Auto
LeveledItem Property LItemSoldierSonsWarhammer Auto
LeveledItem Property LItemWeaponWarhammerTown Auto
LeveledItem Property LItemWeaponWarhammer Auto
LeveledItem Property LItemBanditWarhammer Auto
LeveledItem Property DLC2LItemWeaponWarhammerTown Auto
LeveledItem Property DLC2LItemWeaponWarhammer Auto
LeveledItem Property LItemWeaponWarhammerSpecial Auto
LeveledItem Property LItemOrcStrongholdWarhammer Auto
LeveledItem Property LItemWeaponWarhammerBlacksmith Auto
LeveledItem Property LItemWeaponWarhammerBest Auto
LeveledItem Property LItemBanditBossWarhammer Auto
LeveledItem Property DLC2LItemWeaponWarhammerDremora Auto
LeveledItem Property SublistWeaponWarhammerDaedricBest05 Auto
LeveledItem Property SublistWeaponWarhammerDaedric05 Auto
LeveledItem Property DLC1LItemDaedricWeapon Auto
LeveledItem Property LItemDraugr05EWeapon2H Auto

float Property StoredModVersion = 0.0 Auto
float Property StoredImmersiveWeaponsVersion = 0.0 Auto
float Property StoredBaseLeveledListsVersion = 0.0 Auto
float Property StoredValdacilsItemSortingVersion = 0.0 Auto

string ImmersiveWeapons = "Immersive Weapons.esp"
string ValdacilsItemSorting = "ValdacilsItemSorting.esp"
string UpdateText = "Chairhammers (Chair Warhammers) Updated to "
string LogPrefix = "[Chairhammers] "

Event OnInit()
    RegisterForSingleUpdate(10.0)
EndEvent

Event OnPlayerLoadGame()
    RegisterForSingleUpdate(10.0)
EndEvent

Event OnUpdate()
    If (StoredModVersion < 1.0)
        Maintenance()
        StoredModVersion = 1.0
        Debug.Notification(UpdateText + "1.0")
    Else
        Maintenance()
    EndIf
EndEvent

Function Maintenance()
    Debug.Trace(LogPrefix + "=================Maintenance Start=================")
    UpdateBaseLeveledLists1_0()
    UpdateImmersvieWeapons1_0()
    UpdateValdacilsItemSorting1_0()
    Debug.Trace(LogPrefix + "=================Maintenance End===================")
EndFunction

Function UpdateItemList(LeveledItem itemList, Form addItem, int itemLevel, int itemCount, int repeat = 1)
    int index = 0
    ; Try adding the item to Leveled Item List repeat number of times
    While (index < repeat)
        ; Leveled Lists can only have a max of 255 items, so skip if the list is full
        If (itemList.GetNumForms() == 255)
            ; break out of repeat loop
            index = repeat
            Debug.Trace(LogPrefix + "Skipping adding '" + addItem + "' to '" + itemList + "'. The list is full")
        Else
            Debug.Trace(LogPrefix + "Adding '" + addItem + "' Level '" + itemLevel + "' count '" + itemCount + "' to '" + itemList + "'")
            itemList.AddForm(addItem, itemLevel, itemCount)
        EndIf
        index += 1
    EndWhile
EndFunction

Function UpdateRemoteItemList(string ModName, int FormID, Form addItem, int itemLevel, int itemCount, int repeat = 1)
    Form listForm = Game.GetFormFromFile(FormID, ModName)
    If (listForm == None)
        Debug.Trace(LogPrefix + "Unable to find FormID '" + FormID + "' from '" + ModName + "' Skipping adding '" + addItem + "'" )
        Return
    EndIf
    UpdateItemList(listForm as LeveledItem, addItem, itemLevel, itemCount, repeat)
EndFunction

Function RenameWeaponValdacilsItemSorting(Weapon WeaponToRename)
    string prefix = "[2H Blunt] "
    string oldName = WeaponToRename.GetName()
    If (StringUtil.Find(oldName, prefix) != -1)
        Debug.Trace(LogPrefix + "'" + oldName + "' is already correct on '" + WeaponToRename + "'")
        Return
    EndIf
    string newName = prefix + oldName
    Debug.Trace(LogPrefix + "Renaming '" + oldName + "' to '" + newName + "' on '" + WeaponToRename + "'")
    WeaponToRename.SetName(newName)
EndFunction

Function UpdateBaseLeveledLists1_0()
    If (StoredBaseLeveledListsVersion < 1.0)
        StoredBaseLeveledListsVersion = 1.0
    Else
        Return
    EndIf
    Debug.Trace(LogPrefix + "==========Updating Base Game Leveled Lists=========")
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKCHWeapIronChairhammer, 1, 1, 2)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKCHWeapSteelChairhammer, 3, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKCHWeapSteelChairhammer, 4, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKCHWeapSteelChairhammer, 5, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKCHWeapSteelChairhammer, 6, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKCHWeapDwarvenChairhammer, 12, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKCHWeapDwarvenChairhammer, 13, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKCHWeapDwarvenChairhammer, 14, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKCHWeapDwarvenChairhammer, 15, 1, 1)
    
    UpdateItemList(LItemwerewolfBossWarhammer, MEKCHWeapIronChairhammer, 1, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKCHWeapDwarvenChairhammer, 12, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKCHWeapElvenChairhammer, 19, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKCHWeapGlassChairhammer, 27, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKCHWeapEbonyChairhammer, 36, 1, 1)

    UpdateItemList(LItemSoldierSonsWarhammer, MEKCHWeapIronChairhammer, 1, 1, 2)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKCHWeapSteelChairhammer, 4, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKCHWeapSteelChairhammer, 5, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKCHWeapSteelChairhammer, 6, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKCHWeapSteelChairhammer, 7, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKCHWeapSteelChairhammer, 10, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKCHWeapSteelChairhammer, 11, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKCHWeapSteelChairhammer, 12, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKCHWeapSteelChairhammer, 13, 1, 1)

    UpdateItemList(LItemWeaponWarhammerTown, MEKCHWeapIronChairhammer, 1, 1, 2)
    UpdateItemList(LItemWeaponWarhammerTown, MEKCHWeapSteelChairhammer, 4, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKCHWeapSteelChairhammer, 5, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKCHWeapSteelChairhammer, 6, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKCHWeapSteelChairhammer, 7, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKCHWeapOrcishChairhammer, 13, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKCHWeapDwarvenChairhammer, 18, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKCHWeapElvenChairhammer, 23, 1, 1)

    UpdateItemList(LItemWeaponWarhammer, MEKCHWeapIronChairhammer, 1, 1, 2)
    UpdateItemList(LItemWeaponWarhammer, MEKCHWeapSteelChairhammer, 2, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKCHWeapSteelChairhammer, 3, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKCHWeapSteelChairhammer, 4, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKCHWeapDwarvenChairhammer, 12, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKCHWeapElvenChairhammer, 19, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKCHWeapGlassChairhammer, 27, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKCHWeapEbonyChairhammer, 36, 1, 1)

    UpdateItemList(LItemBanditWarhammer, MEKCHWeapIronChairhammer, 1, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKCHWeapIronChairhammer, 1, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKCHWeapOrcishChairhammer, 9, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKCHWeapDwarvenChairhammer, 15, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKCHWeapElvenChairhammer, 22, 1, 1)

    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKCHWeapIronChairhammer, 1, 1, 2)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKCHWeapSteelChairhammer, 4, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKCHWeapSteelChairhammer, 5, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKCHWeapSteelChairhammer, 6, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKCHWeapSteelChairhammer, 7, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKCHWeapOrcishChairhammer, 13, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKCHWeapDwarvenChairhammer, 18, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKCHWeapElvenChairhammer, 23, 1, 1)
    
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKCHWeapIronChairhammer, 1, 1, 2)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKCHWeapSteelChairhammer, 2, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKCHWeapSteelChairhammer, 3, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKCHWeapSteelChairhammer, 4, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKCHWeapElvenChairhammer, 19, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKCHWeapGlassChairhammer, 27, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKCHWeapEbonyChairhammer, 36, 1, 1)

    UpdateItemList(LItemWeaponWarhammerSpecial, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateItemList(LItemWeaponWarhammerSpecial, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateItemList(LItemWeaponWarhammerSpecial, MEKCHWeapDwarvenChairhammer, 12, 1, 1)
    UpdateItemList(LItemWeaponWarhammerSpecial, MEKCHWeapElvenChairhammer, 19, 1, 1)
    UpdateItemList(LItemWeaponWarhammerSpecial, MEKCHWeapGlassChairhammer, 27, 1, 1)
    UpdateItemList(LItemWeaponWarhammerSpecial, MEKCHWeapEbonyChairhammer, 36, 1, 1)

    UpdateItemList(LItemOrcStrongholdWarhammer, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateItemList(LItemOrcStrongholdWarhammer, MEKCHWeapOrcishChairhammer, 6, 1, 1)

    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKCHWeapSteelChairhammer, 1, 1, 2)
    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKCHWeapDwarvenChairhammer, 12, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKCHWeapElvenChairhammer, 19, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKCHWeapGlassChairhammer, 27, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKCHWeapEbonyChairhammer, 36, 1, 1)

    UpdateItemList(LItemWeaponWarhammerBest, MEKCHWeapSteelChairhammer, 1, 1, 2)
    UpdateItemList(LItemWeaponWarhammerBest, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBest, MEKCHWeapDwarvenChairhammer, 12, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBest, MEKCHWeapElvenChairhammer, 19, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBest, MEKCHWeapGlassChairhammer, 27, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBest, MEKCHWeapEbonyChairhammer, 36, 1, 1)

    UpdateItemList(LItemBanditBossWarhammer, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateItemList(LItemBanditBossWarhammer, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateItemList(LItemBanditBossWarhammer, MEKCHWeapDwarvenChairhammer, 12, 1, 1)
    UpdateItemList(LItemBanditBossWarhammer, MEKCHWeapElvenChairhammer, 19, 1, 1)
    UpdateItemList(LItemBanditBossWarhammer, MEKCHWeapGlassChairhammer, 27, 1, 1)
    UpdateItemList(LItemBanditBossWarhammer, MEKCHWeapEbonyChairhammer, 36, 1, 1)

    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKCHWeapDwarvenChairhammer, 13, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKCHWeapElvenChairhammer, 21, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKCHWeapGlassChairhammer, 30, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKCHWeapEbonyChairhammer, 40, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKCHWeapDaedricChairhammer, 51, 1, 1)

    UpdateItemList(SublistWeaponWarhammerDaedricBest05, MEKCHWeapDaedricChairhammer, 1, 1, 1)

    UpdateItemList(SublistWeaponWarhammerDaedric05, MEKCHWeapDaedricChairhammer, 1, 1, 1)

    UpdateItemList(DLC1LItemDaedricWeapon, MEKCHWeapEbonyChairhammer, 1, 1, 4)
    UpdateItemList(DLC1LItemDaedricWeapon, MEKCHWeapDaedricChairhammer, 1, 1, 2)
    UpdateItemList(DLC1LItemDaedricWeapon, DaedricWarhammer, 1, 1, 2)

    UpdateItemList(LItemDraugr05EWeapon2H, MEKCHWeapEbonyChairhammer, 1, 1, 1)

    Debug.Trace(LogPrefix + "==========Base Game Leveled Lists Updated==========")
EndFunction

Function UpdateImmersvieWeapons1_0()
    If (Game.GetModByName(ImmersiveWeapons) == 255)
        Return
    EndIf
    If (StoredImmersiveWeaponsVersion < 1.0)
        StoredImmersiveWeaponsVersion = 1.0
    Else
        Return
    EndIf
    Debug.Trace(LogPrefix + "Immersive Armors Detected. Updating leveled lists")

    int IWLIWeaponWarhammer = 0x0001CB26
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer, MEKCHWeapDwarvenChairhammer, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer,  MEKCHWeapElvenChairhammer, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer,  MEKCHWeapGlassChairhammer, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer,  MEKCHWeapEbonyChairhammer, 40, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer,  MEKCHWeapDaedricChairhammer, 51, 1, 1)

    int IWLIBanditWarhammer = 0x0001D603
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer, MEKCHWeapDwarvenChairhammer, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer,  MEKCHWeapElvenChairhammer, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer,  MEKCHWeapGlassChairhammer, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer,  MEKCHWeapEbonyChairhammer, 40, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer,  MEKCHWeapDaedricChairhammer, 51, 1, 1)

    int IWLISoldierSonsWeapon2H = 0x0001F0F6
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCHWeapDwarvenChairhammer, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKCHWeapElvenChairhammer, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKCHWeapGlassChairhammer, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKCHWeapEbonyChairhammer, 40, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKCHWeapDaedricChairhammer, 51, 1, 1)

    int IWLITownWarhammer = 0x000365C4
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownWarhammer, MEKCHWeapIronChairhammer, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownWarhammer, MEKCHWeapSteelChairhammer, 2, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownWarhammer, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownWarhammer, MEKCHWeapDwarvenChairhammer, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownWarhammer,  MEKCHWeapElvenChairhammer, 21, 1, 1)

    int IWLI_ListWarhammer = 0x00039B9E
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKCHWeapDwarvenChairhammer, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKCHWeapElvenChairhammer, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKCHWeapGlassChairhammer, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKCHWeapEbonyChairhammer, 40, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKCHWeapDaedricChairhammer, 51, 1, 1)

    int IWLIBoss2H = 0x0003FCB7
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H, MEKCHWeapDwarvenChairhammer, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H,  MEKCHWeapElvenChairhammer, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H,  MEKCHWeapGlassChairhammer, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H,  MEKCHWeapEbonyChairhammer, 40, 1, 1)

    int IWLIBlacksmithWarhammer = 0x00040CF6
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer, MEKCHWeapDwarvenChairhammer, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer,  MEKCHWeapElvenChairhammer, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer,  MEKCHWeapGlassChairhammer, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer,  MEKCHWeapEbonyChairhammer, 40, 1, 1)

    int IWLIBestWarhammer = 0x00040CF7
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer, MEKCHWeapDwarvenChairhammer, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer,  MEKCHWeapElvenChairhammer, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer,  MEKCHWeapGlassChairhammer, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer,  MEKCHWeapEbonyChairhammer, 40, 1, 1)

    int IWLIVRareWarhammerBest = 0x0004125C
    UpdateRemoteItemList(ImmersiveWeapons, IWLIVRareWarhammerBest,  MEKCHWeapDaedricChairhammer, 1, 1, 1)

    int IWLIOrcWarhammer = 0x000417C1
    UpdateRemoteItemList(ImmersiveWeapons, IWLIOrcWarhammer, MEKCHWeapOrcishChairhammer, 6, 1, 1)

    int IWLIDraugr2H = 0x000417C7
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKCHWeapSteelChairhammer, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKCHWeapOrcishChairhammer, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKCHWeapDwarvenChairhammer, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H,  MEKCHWeapElvenChairhammer, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H,  MEKCHWeapGlassChairhammer, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H,  MEKCHWeapEbonyChairhammer, 40, 1, 1)

    int IWLIEbony2H = 0x000417CA
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H,  MEKCHWeapEbonyChairhammer, 1, 1, 1)

    Debug.Trace(LogPrefix + "Immersive Armors leveled lists updated.")
EndFunction

Function UpdateValdacilsItemSorting1_0()
    If (Game.GetModByName(ValdacilsItemSorting) == 255)
        Return
    EndIf
    If (StoredValdacilsItemSortingVersion < 1.0)
        StoredValdacilsItemSortingVersion = 1.0
    Else
        Return
    EndIf

    Debug.Trace(LogPrefix + "Valdacil's Item Sorting Detected. Updating Weapon Names")
    RenameWeaponValdacilsItemSorting(MEKCHWeapIronChairhammer)
    RenameWeaponValdacilsItemSorting(MEKCHWeapDaedricChairhammer)
    RenameWeaponValdacilsItemSorting(MEKCHWeapDwarvenChairhammer)
    RenameWeaponValdacilsItemSorting(MEKCHWeapEbonyChairhammer)
    RenameWeaponValdacilsItemSorting(MEKCHWeapElvenChairhammer)
    RenameWeaponValdacilsItemSorting(MEKCHWeapGlassChairhammer)
    RenameWeaponValdacilsItemSorting(MEKCHWeapOrcishChairhammer)
    RenameWeaponValdacilsItemSorting(MEKCHWeapSteelChairhammer)
    Debug.Trace(LogPrefix + "Valdacil's Item Sorting Names Set")
EndFunction
