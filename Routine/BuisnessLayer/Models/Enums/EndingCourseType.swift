import Foundation

enum EndingCourseType: Int {
    case endUsageDate
    case countUsageDays
    case countUsageNumber
    
    func toString() -> String {
        return EndingCourseType.stringBy(self)
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
    
    static func stringBy(_ value: EndingCourseType) -> String {
        switch value {
        case .endUsageDate: return AppDelegate.serviceProvider.makeStringService().localizeById("drug_times_todate")
        case .countUsageDays: return AppDelegate.serviceProvider.makeStringService().localizeById("drug_times_days")
        case .countUsageNumber: return AppDelegate.serviceProvider.makeStringService().localizeById("drug_times_usages")
        }
    }
    
    static func pluralsStringBy(_ type: EndingCourseType, count: Int) -> String {
        var typeString: String
        
        switch type {
        case .endUsageDate:
            let date = Date(timeIntervalSince1970: Double(count) / 1000.0)
            return "\(AppDelegate.serviceProvider.makeStringService().localizeById("drug_times_to")) \(date.format(with: "dd.MM.yyyy"))"
        case .countUsageDays:
            typeString = AppDelegate.serviceProvider.makeStringService().pluralsLocalizeByIds(str1: "days1", str24: "days2_4", str5: "days5", count: count)
            return "\(count) \(typeString.lowercased())"
        case .countUsageNumber:
            typeString = AppDelegate.serviceProvider.makeStringService().pluralsLocalizeByIds(str1: "usage_1", str24: "usage_2_4", str5: "usage_5", count: count)
                return "\(count) \(typeString.lowercased())"
        }
    }
}
