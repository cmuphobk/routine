import Foundation

enum PeriodType: Int, CaseIterable {
    case weekDays
    case countDays

    var value: Int {
        switch self {
        case .weekDays: return 1
        case .countDays: return 2
        }
    }

    static func fromValue(_ value: Int) -> PeriodType? {
        switch value {
        case 1: return .weekDays
        case 2: return .countDays
        default:
            return nil
        }
    }

    func toString(localizeService: StringServiceInterface) -> String {
        switch self {
        case .weekDays:
            return localizeService.localizeId(R.string.localizable.week_days.key)
        case .countDays:
            return localizeService.localizeId(R.string.localizable.count_days.key)
        }
    }
}
