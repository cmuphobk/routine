
import Foundation


extension Date {
    
    var timeIntervalFromStartDay: TimeInterval {
        guard let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self) else { return 0 }
        return Double(self.timeIntervalSince1970 * 1000 - startDate.timeIntervalSince1970 * 1000)
    }
}
