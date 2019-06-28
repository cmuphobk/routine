import Foundation

struct NotificationsModel {
    let startDate: Int
    let times: [Time]
    let periodType: PeriodType
    let periodValue: Int
    let endingType: EndingType
    let endingValue: Int
    let userInfo: CustomStringConvertible
}
