import Foundation

enum EndingCourseType: Int {
    case endUsageDate
    case countUsageDays
    case countUsageNumber
    
    func toString(localizeService: StringServiceInterface) -> String {
        switch self {
        case .endUsageDate: return localizeService.localizeId("drug_times_todate")
        case .countUsageDays: return localizeService.localizeId("drug_times_days")
        case .countUsageNumber: return localizeService.localizeId("drug_times_usages")
        }
    }
    
    func toPluralsString(count: Int, localizeService: StringServiceInterface) -> String {
        var typeString: String
        
        switch self {
        case .endUsageDate:
            let date = Date(timeIntervalSince1970: Double(count) / 1000.0)
            return "\(localizeService.localizeId("drug_times_to")) \(date.format(with: "dd.MM.yyyy"))"
        case .countUsageDays:
            typeString = localizeService.pluralsLocalizeId(str1: "days1", str24: "days2_4", str5: "days5", count: count)
            return "\(count) \(typeString.lowercased())"
        case .countUsageNumber:
            typeString = localizeService.pluralsLocalizeId(str1: "usage_1", str24: "usage_2_4", str5: "usage_5", count: count)
            return "\(count) \(typeString.lowercased())"
        }
    }
    
    var value: Int {
        switch self {
        case .endUsageDate: return 1
        case .countUsageDays: return 2
        case .countUsageNumber: return 3
        }
    }
    
    static func fromValue(_ value: Int) -> EndingCourseType? {
        switch value {
        case 1: return .endUsageDate
        case 2: return .countUsageDays
        case 3: return .countUsageNumber
        default:
            return nil
        }
    }
    
    
}
