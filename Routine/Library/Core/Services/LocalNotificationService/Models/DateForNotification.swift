import Foundation

struct DateForNotification: Hashable {
    let timestamp: Int
    let userInfo: CustomStringConvertible

    func hash(into hasher: inout Hasher) {
        hasher.combine(NSUUID().uuidString)
    }

    static func == (lhs: DateForNotification, rhs: DateForNotification) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
