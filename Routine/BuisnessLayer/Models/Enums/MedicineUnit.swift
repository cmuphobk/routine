import UIKit

enum MedicineUnit: Int, StandartPickerTitleModel, CaseIterable {
    case drop //капля
    case gramm //гр
    case shot //укол
    case mgr //мг
    case mkg //мкг
    case mll //мл
    case pill //таблетка
    case inject //впрыски
    case tablespoon //ст ложка
    case teaspoon //ч ложка
    case item //шт
    
    case unitOfAction//МЕ
    case proc //проценты
    case mkgMl //мкг/мл
    case mgMl //мг/мл
    case capsule //капсулы
    case measuringSpoon //мерная ложка
    case dessertSpoon //десертная ложка
    case smCubic //куб. см
    case powder //порошок
    case hitch //навеска
    case tube //тюбик
    case jar //банка
    case dose //доза
    case suppository //суппозитории

    var value: Int {
        switch self {
        case .drop: return 1
        case .gramm: return 2
        case .shot: return 3
        case .mgr: return 4
        case .mkg: return 5
        case .mll: return 6
        case .pill: return 7
        case .inject: return 8
        case .tablespoon: return 9
        case .teaspoon: return 10
        case .item: return 11
        case .unitOfAction : return 12
        case .proc: return 13
        case .mkgMl: return 14
        case .mgMl: return 15
        case .capsule: return 16
        case .measuringSpoon: return 17
        case .dessertSpoon: return 18
        case .smCubic: return 19
        case .powder: return 20
        case .hitch: return 21
        case .tube: return 22
        case .jar: return 23
        case .dose: return 24
        case .suppository: return 25
        }
    }
    
    static func fromValue(_ value: Int) -> MedicineUnit? {
        switch value {
        case 1: return .drop
        case 2: return .gramm
        case 3: return .shot
        case 4: return .mgr
        case 5: return .mkg
        case 6: return .mll
        case 7: return .pill
        case 8: return .inject
        case 9: return .tablespoon
        case 10: return .teaspoon
        case 11: return .item
        case 12: return .unitOfAction

        case 13: return .proc
        case 14: return .mkgMl
        case 15: return .mgMl
        case 16: return .capsule
        case 17: return .measuringSpoon
        case 18: return .dessertSpoon
        case 19: return .smCubic
        case 20: return .powder
        case 21: return .hitch
        case 22: return .tube
        case 23: return .jar
        case 24: return .dose
        case 25: return .suppository
        default:
                return nil
        }
    }
    
    func toString(localizeService: StringServiceInterface) -> String {
        switch self {
        case .drop:
            return localizeService.localizeId("drop")
        case .gramm:
            return localizeService.localizeId("gramm")
        case .shot:
            return localizeService.localizeId("shot")
        case .mgr:
            return localizeService.localizeId("mg")
        case .mkg:
            return localizeService.localizeId("mkg")
        case .mll:
            return localizeService.localizeId("ml")
        case .pill:
            return localizeService.localizeId("pill")
        case .inject:
            return localizeService.localizeId("inject")
        case .tablespoon:
            return localizeService.localizeId("tablespoon")
        case .teaspoon:
            return localizeService.localizeId("teaspoon")
        case .item:
            return localizeService.localizeId("item")
        case .unitOfAction: return localizeService.localizeId("me")
        case .proc:
            return localizeService.localizeId("proc")
        case .mkgMl:
            return localizeService.localizeId("mkgMl")
        case .mgMl:
            return localizeService.localizeId("mgMl")
        case .capsule:
            return localizeService.localizeId("capsule")
        case .measuringSpoon:
            return localizeService.localizeId("measuringSpoon")
        case .dessertSpoon:
            return localizeService.localizeId("dessertSpoon")
        case .smCubic:
            return localizeService.localizeId("smCubic")
        case .powder:
            return localizeService.localizeId("powder")
        case .hitch:
            return localizeService.localizeId("hitch")
        case .tube:
            return localizeService.localizeId("tube")
        case .jar:
            return localizeService.localizeId("jar")
        case .dose:
            return localizeService.localizeId("dose")
        case .suppository:
            return localizeService.localizeId("suppository")
        }
    }
    
    func pluralsStringFor(count: Int, localizeService: StringServiceInterface) -> String {
        switch self {
        case .drop:
            return localizeService.pluralsLocalizeId(str1: "drop_1", str24: "drop_2_4", str5: "drop_5", count: count)
        case .gramm:
            return localizeService.pluralsLocalizeId(str1: "gramm_1", str24: "gramm_2_4", str5: "gramm_5", count: count)
        case .shot:
            return localizeService.pluralsLocalizeId(str1: "shot_1", str24: "shot_2_4", str5: "shot_5", count: count)
        case .mgr:
            return localizeService.pluralsLocalizeId(str1: "mg_1", str24: "mg_2_4", str5: "mg_5", count: count)
        case .mkg:
            return localizeService.pluralsLocalizeId(str1: "mkg_1", str24: "mkg_2_4", str5: "mkg_5", count: count)
        case .mll:
            return localizeService.pluralsLocalizeId(str1: "ml_1", str24: "mlс", str5: "ml_5", count: count)
        case .pill:
            return localizeService.pluralsLocalizeId(str1: "pill_1", str24: "pill_2_4", str5: "pill_5", count: count)
        case .inject:
            return localizeService.pluralsLocalizeId(str1: "inject_1", str24: "inject_2_4", str5: "inject_5", count: count)
        case .tablespoon:
            return localizeService.pluralsLocalizeId(str1: "tablespoon_1", str24: "tablespoon_2_4", str5: "tablespoon_5", count: count)
        case .teaspoon:
            return localizeService.pluralsLocalizeId(str1: "teaspoon_1", str24: "teaspoon_2_4", str5: "teaspoon_5", count: count)
        case .item:
            return localizeService.pluralsLocalizeId(str1: "item_1", str24: "item_2_4", str5: "item_5", count: count)
        case .unitOfAction:
            return localizeService.pluralsLocalizeId(str1: "me_1", str24: "me_2_4", str5: "me_5", count: count)
        case .proc:
            return localizeService.pluralsLocalizeId(str1: "proc_1", str24: "proc_2_4", str5: "proc_5", count: count)
        case .mkgMl:
            return localizeService.pluralsLocalizeId(str1: "mkgMl_1", str24: "mkgMl_2_4", str5: "mkgMl_5", count: count)
        case .mgMl:
            return localizeService.pluralsLocalizeId(str1: "mgMl_1", str24: "mgMl_2_4", str5: "mgMl_5", count: count)
        case .capsule:
            return localizeService.pluralsLocalizeId(str1: "capsule_1", str24: "capsule_2_4", str5: "capsule_5", count: count)
        case .measuringSpoon:
            return localizeService.pluralsLocalizeId(str1: "measuringSpoon_1", str24: "measuringSpoon_2_4", str5: "measuringSpoon_5", count: count)
        case .dessertSpoon:
            return localizeService.pluralsLocalizeId(str1: "dessertSpoon_1", str24: "dessertSpoon_2_4", str5: "dessertSpoon_5", count: count)
        case .smCubic:
            return localizeService.pluralsLocalizeId(str1: "smCubic_1", str24: "smCubic_2_4", str5: "smCubic_5", count: count)
        case .powder:
            return localizeService.pluralsLocalizeId(str1: "powder_1", str24: "powder_2_4", str5: "powder_5", count: count)
        case .hitch:
            return localizeService.pluralsLocalizeId(str1: "hitch_1", str24: "hitch_2_4", str5: "hitch_5", count: count)
        case .tube:
            return localizeService.pluralsLocalizeId(str1: "tube_1", str24: "tube_2_4", str5: "tube_5", count: count)
        case .jar:
            return localizeService.pluralsLocalizeId(str1: "jar_1", str24: "jar_2_4", str5: "jar_5", count: count)
        case .dose:
            return localizeService.pluralsLocalizeId(str1: "dose_1", str24: "dose_2_4", str5: "dose_5", count: count)
        case .suppository:
            return localizeService.pluralsLocalizeId(str1: "suppository_1", str24: "suppository_2_4", str5: "suppository_5", count: count)
        }
    }
}

// Utils
extension MedicineUnit {
    
    static func convertToSimpleComboboxUnits(localizeService: StringServiceInterface) -> [SimpleComboboxUnit] {
        
        return MedicineUnit.allCases.map { (item) -> SimpleComboboxUnit in
            return SimpleComboboxUnit(value: item.toString(localizeService: localizeService))
        }
        
    }
    
}
