import Foundation

struct Time {
    
    private let kMinute: Int = 60000  // миллисекунд в минуте
    private var timeValue: Int  // время дня в миллисекундах, например 11:00 или 12:30
    
    init() {
        self.timeValue = 0
    }
    
    init(hours: Int, minutes: Int) {
        self.init()
        self.setTime(hours: hours, minutes: minutes)
    }
    
    mutating func setTime(hours: Int, minutes: Int) {
        self.timeValue = (hours * 60 * kMinute) + (minutes * kMinute)
    }
    mutating func setTime(milisec: Int) {
        self.timeValue = milisec
    }
    
    func rawValue() -> Int {
        return self.timeValue
    }
    
    func components() -> (hours: Int, minutes: Int) {
        var result: (hours: Int, minutes: Int) = (hours: 0, minutes: 0)
        
        result.hours = Int(self.timeValue / (60 * kMinute))
        result.minutes = ( self.timeValue - (result.hours * 60 * kMinute) ) / kMinute
        
        return result
    }
    
    func toString() -> String {
        let components = self.components()
        return "\(String(format: "%02d", components.hours)):\(String(format: "%02d", components.minutes))"
    }
}
