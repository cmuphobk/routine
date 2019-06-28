import Foundation

enum LocalNotificationServiceAssembly {
    static func build(storageService: StorageServiceInterface) -> LocalNotificationServiceInterface {
        let localNotification = LocalNotificationService()
        localNotification.storageService = storageService
        return localNotification
    }
}
