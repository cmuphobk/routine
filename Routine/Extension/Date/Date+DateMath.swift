import UIKit

extension Date {
    
    static func calcPercentPartByToday(fromDate: Date, toDate: Date) -> CGFloat {
        let currentDate = Date()
        
        if currentDate > toDate {
            return 1.0
        } else {
            let percentage = (currentDate.timeIntervalSince1970 - fromDate.timeIntervalSince1970) / (toDate.timeIntervalSince1970 - fromDate.timeIntervalSince1970)
            return CGFloat(percentage)
        }
    }
    
}
