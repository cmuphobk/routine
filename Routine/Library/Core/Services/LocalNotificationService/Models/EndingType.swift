import Foundation

enum EndingType: Int {
    case endUsageDate
    case countUsageDays
    case countUsageNumber

    func toString(localizeService: StringServiceInterface) -> String {
        switch self {
        case .endUsageDate: return localizeService.localizeId(R.string.localizable.end_usage_date.key)
        case .countUsageDays: return localizeService.localizeId(R.string.localizable.count_usage_days.key)
        case .countUsageNumber: return localizeService.localizeId(R.string.localizable.count_usage_number.key)
        }
    }

    func toPluralsString(count: Int, localizeService: StringServiceInterface) -> String {
        var typeString: String

        switch self {
        case .endUsageDate:
            let date = Date(timeIntervalSince1970: Double(count) / 1000.0)
            let dateFormat = date.format(with: "dd.MM.yyyy")
            let string = localizeService.localizeId(R.string.localizable.end_usage_date_to.key)
            return "\(string) \(dateFormat)"
        case .countUsageDays:
            typeString = localizeService.pluralsLocalizeId(str1: R.string.localizable.days_1.key,
                                                           str24: R.string.localizable.days2_4.key,
                                                           str5: R.string.localizable.days5.key,
                                                           count: count)
            return "\(count) \(typeString.lowercased())"
        case .countUsageNumber:
            typeString = localizeService.pluralsLocalizeId(str1: R.string.localizable.usage_1.key,
                                                           str24: R.string.localizable.usage_2_4.key,
                                                           str5: R.string.localizable.usage_5.key,
                                                           count: count)
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

    static func fromValue(_ value: Int) -> EndingType? {
        switch value {
        case 1: return .endUsageDate
        case 2: return .countUsageDays
        case 3: return .countUsageNumber
        default:
            return nil
        }
    }

}
