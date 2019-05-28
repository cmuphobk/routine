import Foundation

enum NotificationServiceAssembly {

    static func build() -> NotificationServiceInterface {

        let notificationService = NotificationService.shared

        return notificationService

    }

}
