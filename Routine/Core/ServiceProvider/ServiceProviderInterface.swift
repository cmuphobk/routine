import Foundation

protocol ServiceProviderInterface {
    func makeLanguageService() -> LanguageServiceInterface
    func makeStringService() -> StringServiceInterface
    func makeImageService() -> ImageServiceInterface
    func makeDateService() -> DateServiceInterface
    func makeLocalNotificationService() -> LocalNotificationServiceInterface
    func makeStorageService() -> StorageServiceInterface
    func makeModuleService() -> ModuleServiceInterface
    func makeWindowService() -> WindowServiceInterface
    func makeReachabilityService() -> ReachabilityServiceInterface
    func makeNotificationService() -> NotificationServiceInterface
}
