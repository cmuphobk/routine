import UIKit

enum MedicineType: Int, StandartPickerTitleModel, CaseIterable {
    case ampoules
    case capsules
    case drops
    case injections
    case pills
    case powder
    case ointment
    case sprays
    case candles
    case syrup
    
    var value: Int {
        switch self {
        case .ampoules: return 1
        case .capsules: return 2
        case .drops: return 3
        case .injections: return 4
        case .pills: return 5
        case .powder: return 6
        case .ointment: return 7
        case .sprays: return 8
        case .candles: return 9
        case .syrup: return 10
        }
    }
    
    static func fromValue(_ value: Int) -> MedicineType? {
        
        switch value {
        case 1: return .ampoules
        case 2: return .capsules
        case 3: return .drops
        case 4: return .injections
        case 5: return .pills
        case 6: return .powder
        case 7: return .ointment
        case 8: return .sprays
        case 9: return .candles
        case 10: return .syrup
        default:
            return nil
        }
    }
    
    static func imageBy(_ value: MedicineType) -> UIImage {
        switch value {
        case .ampoules: return R.image.ampoules() ?? UIImage()
        case .capsules: return R.image.capsules() ?? UIImage()
        case .drops: return R.image.drops() ?? UIImage()
        case .injections: return R.image.injections() ?? UIImage()
        case .pills: return R.image.pills() ?? UIImage()
        case .powder: return R.image.powder() ?? UIImage()
        case .ointment: return R.image.ointment() ?? UIImage()
        case .sprays: return R.image.sprays() ?? UIImage()
        case .candles: return R.image.candles() ?? UIImage()
        case .syrup: return R.image.syrup() ?? UIImage()
        }
        
    }
    
    func toString(localizeService: StringServiceInterface) -> String {
        switch self {
        case .ampoules:
            return localizeService.localizeId("ampoules")
        case .capsules:
            return localizeService.localizeId("capsules")
        case .drops:
            return localizeService.localizeId("drops")
        case .injections:
            return localizeService.localizeId("injections")
        case .pills:
            return localizeService.localizeId("pills")
        case .powder:
            return localizeService.localizeId("powder")
        case .ointment:
            return localizeService.localizeId("ointment")
        case .sprays:
            return localizeService.localizeId("sprays")
        case .candles:
            return localizeService.localizeId("candles")
        case .syrup:
            return localizeService.localizeId("syrup")
        }
    }
    
    func pluralsStringFor(count: Int, localizeService: StringServiceInterface) -> String {
        switch self {
        case .ampoules:
            return localizeService.pluralsLocalizeId(str1: "ampoules_1", str24: "ampoules_2_4", str5: "ampoules_5", count: count)
        case .capsules:
            return localizeService.pluralsLocalizeId(str1: "capsules_1", str24: "capsules_2_4", str5: "capsules_5", count: count)
        case .drops:
            return localizeService.pluralsLocalizeId(str1: "drops_1", str24: "drops_2_4", str5: "drops_5", count: count)
        case .injections:
            return localizeService.pluralsLocalizeId(str1: "injections_1", str24: "injections_2_4", str5: "injections_5", count: count)
        case .pills:
            return localizeService.pluralsLocalizeId(str1: "pills_1", str24: "pills_2_4", str5: "pills_5", count: count)
        case .powder:
            return localizeService.pluralsLocalizeId(str1: "powder_1", str24: "powder_2_4", str5: "powder_5", count: count)
        case .ointment:
            return localizeService.pluralsLocalizeId(str1: "ointment_1", str24: "ointment_2_4", str5: "ointment_5", count: count)
        case .sprays:
            return localizeService.pluralsLocalizeId(str1: "sprays_1", str24: "sprays_2_4", str5: "sprays_5", count: count)
        case .candles:
            return localizeService.pluralsLocalizeId(str1: "candles_1", str24: "candles_2_4", str5: "candles_5", count: count)
        case .syrup:
            return localizeService.pluralsLocalizeId(str1: "syrup_1", str24: "syrup_2_4", str5: "syrup_5", count: count)
        }
    }
    
    func obtainUnitsForType() -> [MedicineUnit] {
        var array: [MedicineUnit] = []
        
        switch self {
        case .ampoules: array = [.unitOfAction, .item, .proc, .mkg, .mgr, .mkgMl, .mgMl]
        case .capsules: array = [.item, .capsule, .mgr, .unitOfAction, .mkg]
        case .drops: array = [.drop, .mll, .unitOfAction, .tablespoon, .teaspoon, .dessertSpoon, .measuringSpoon, .proc]
        case .injections: array = [.unitOfAction, .smCubic, .gramm, .mkg, .proc]
        case .pills: array = [.pill, .item, .mgr, .unitOfAction, .mkg]
        case .powder: array = [.mkg, .gramm, .mgr, .powder, .hitch]
        case .ointment: array = [.gramm, .mgr, .tube, .jar]
        case .sprays: array = [.inject, .mll, .dose]
        case .candles: array = [.unitOfAction, .item, .suppository, .mkg]
        case .syrup: array = [.mll, .mgr, .tablespoon, .teaspoon, .dessertSpoon, .measuringSpoon, .drop, .mkg]
        }
        return array
    }
    
    func obtainUnitComboboxesForType(localizeService: StringServiceInterface) -> [SimpleComboboxUnit] {
        
        return self.obtainUnitsForType().map { (item) -> SimpleComboboxUnit in
            return SimpleComboboxUnit(value: item.toString(localizeService: localizeService))
        }
        
    }
}

// Utils
extension MedicineType {
    
    static func convertToSimpleComboboxUnits(localizeService: StringServiceInterface) -> [SimpleComboboxUnit] {
        
        return MedicineType.allCases.map { (item) -> SimpleComboboxUnit in
            return SimpleComboboxUnit(value: item.toString(localizeService: localizeService))
        }
        
    }
    
}
