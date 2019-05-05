import Foundation

enum LocalNotificationServiceAssembly {
    
    static func build(storageService: StorageServiceInterface) -> LocalNotificationServiceInterface {
        
        let localNotification = LocalNotificationService.shared
        localNotification.storageService = storageService
        return localNotification
        
    }
    
}
