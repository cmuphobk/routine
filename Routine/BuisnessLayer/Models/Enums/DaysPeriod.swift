import UIKit

enum DaysPeriod: Int, CaseIterable {
    case days1
    case days2
    case days3
    case days4
    case days5
    case days6
    case days7
    case days8
    
    var value: Int {
        switch self {
        case .days1: return 1
        case .days2: return 2
        case .days3: return 3
        case .days4: return 4
        case .days5: return 5
        case .days6: return 6
        case .days7: return 7
        case .days8: return 8
        }
    }
    
    static func fromValue(_ value: Int) -> DaysPeriod? {
        switch value {
        case 1: return .days1
        case 2: return .days2
        case 3: return .days3
        case 4: return .days4
        case 5: return .days5
        case 6: return .days6
        case 7: return .days7
        case 8: return .days8
        default:
            return nil
        }
    }
    
    func toString() -> String {
        switch self {
        case .days1: return AppDelegate.serviceProvider.makeStringService().localizeById("per_1_day")
        case .days2: return AppDelegate.serviceProvider.makeStringService().localizeById("per_2_day")
        case .days3: return AppDelegate.serviceProvider.makeStringService().localizeById("per_3_day")
        case .days4: return AppDelegate.serviceProvider.makeStringService().localizeById("per_4_day")
        case .days5: return AppDelegate.serviceProvider.makeStringService().localizeById("per_5_day")
        case .days6: return AppDelegate.serviceProvider.makeStringService().localizeById("per_6_day")
        case .days7: return AppDelegate.serviceProvider.makeStringService().localizeById("per_7_day")
        case .days8: return AppDelegate.serviceProvider.makeStringService().localizeById("per_8_day")
        }
    }
    
    static func toStringArray() -> [String] {
        var result: [String] = []
        
        for item in DaysPeriod.allCases {
            result += [item.toString()]
        }
        
        return result
    }
}
