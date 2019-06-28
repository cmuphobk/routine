import Foundation

struct LocalNotification: Codable {
    var name: String
    var timestamp: Int
    var categoryIdentifier: String
    var title: String
}
