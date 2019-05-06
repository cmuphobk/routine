import Foundation
import UserNotifications

struct MedicineLocalNotification: Codable {
    var name: String
    var timestamp: Int
    var categoryIdentifier: String
    var title: String
    var body: String
}
