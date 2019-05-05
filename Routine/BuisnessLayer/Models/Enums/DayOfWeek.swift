import Foundation

enum DayOfWeek: UInt8, CaseIterable {
    
    case monday    = 0b00000001
    case tuesday   = 0b00000010
    case wednesday = 0b00000100
    case thursday  = 0b00001000
    case friday    = 0b00010000
    case saturday  = 0b00100000
    case sunday    = 0b01000000
    
    static var allDay: UInt8 { return 0b01111111 } 
    
    //Проверить есть ли день в наборе дней
    func checkIfExist(_ enter: UInt8) -> Bool {
        
        let int8 = self.rawValue
        
        return enter & int8 == int8
    }
    
    //Сложить два дня недели
    static func + (left: DayOfWeek, right: DayOfWeek) -> UInt8 {
        return left.rawValue | right.rawValue
    }
    
    //Прибавить день к множеству
    static func + (left: UInt8, right: DayOfWeek) -> UInt8 {
        return left | right.rawValue
    }
    
    //получить день по Int
    static func dayOfWeekFromWeekday(_ weekday: Int) -> DayOfWeek? {
        
        if weekday == 1 {
            
            return .monday
            
        } else if weekday == 2 {
            
            return .tuesday
            
        } else if weekday == 3 {
            
            return .wednesday
            
        } else if weekday == 4 {
            
            return .thursday
            
        } else if weekday == 5 {
            
            return .friday
            
        } else if weekday == 6 {
            
            return .saturday
            
        } else if weekday == 7 {
            
            return .sunday
            
        } else { return nil }
        
    }
    
    //Определить по timestamp какой день недели
    static func checkDateWeekDay(timestamp: Int) -> DayOfWeek? {
        
        let date = Date(timeIntervalSince1970: Double(timestamp / 1000))
        let weekday = date.weekday
        return self.dayOfWeekFromWeekday(weekday)
        
    }
    
    static func stringBy(_ value: DayOfWeek) -> String {
        switch value {
        case .monday: return AppDelegate.serviceProvider.makeStringService().localizeById("short_monday")
        case .tuesday: return AppDelegate.serviceProvider.makeStringService().localizeById("short_tuesday")
        case .wednesday: return AppDelegate.serviceProvider.makeStringService().localizeById("short_wednesday")
        case .thursday: return AppDelegate.serviceProvider.makeStringService().localizeById("short_thursday")
        case .friday: return AppDelegate.serviceProvider.makeStringService().localizeById("short_friday")
        case .saturday: return AppDelegate.serviceProvider.makeStringService().localizeById("short_saturday")
        case .sunday: return AppDelegate.serviceProvider.makeStringService().localizeById("short_sunday")
        }
    }
    
    func toFullString() -> String {
        switch self {
        case .monday: return AppDelegate.serviceProvider.makeStringService().localizeById("full_monday")
        case .tuesday: return AppDelegate.serviceProvider.makeStringService().localizeById("full_tuesday")
        case .wednesday: return AppDelegate.serviceProvider.makeStringService().localizeById("full_wednesday")
        case .thursday: return AppDelegate.serviceProvider.makeStringService().localizeById("full_thursday")
        case .friday: return AppDelegate.serviceProvider.makeStringService().localizeById("full_friday")
        case .saturday: return AppDelegate.serviceProvider.makeStringService().localizeById("full_saturday")
        case .sunday: return AppDelegate.serviceProvider.makeStringService().localizeById("full_sunday")
        }
    }
    
    static func stringFromBitset(_ bitset: UInt8) -> String {
        var result: String = ""
        
        if DayOfWeek.monday.checkIfExist(bitset) {
            result.append( "\(AppDelegate.serviceProvider.makeStringService().localizeById("short_monday")). " )
        }
        if DayOfWeek.tuesday.checkIfExist(bitset) {
            result.append( "\(AppDelegate.serviceProvider.makeStringService().localizeById("short_tuesday")). " )
        }
        if DayOfWeek.wednesday.checkIfExist(bitset) {
            result.append( "\(AppDelegate.serviceProvider.makeStringService().localizeById("short_wednesday")). " )
        }
        if DayOfWeek.thursday.checkIfExist(bitset) {
            result.append( "\(AppDelegate.serviceProvider.makeStringService().localizeById("short_thursday")). " )
        }
        if DayOfWeek.friday.checkIfExist(bitset) {
            result.append( "\(AppDelegate.serviceProvider.makeStringService().localizeById("short_friday")). " )
        }
        if DayOfWeek.saturday.checkIfExist(bitset) {
            result.append( "\(AppDelegate.serviceProvider.makeStringService().localizeById("short_saturday")). " )
        }
        if DayOfWeek.sunday.checkIfExist(bitset) {
            result.append( "\(AppDelegate.serviceProvider.makeStringService().localizeById("short_sunday")). " )
        }
        
        return result
    }
}
