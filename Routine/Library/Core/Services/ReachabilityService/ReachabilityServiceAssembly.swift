import Foundation

enum ReachabilityServiceAssembly {
    static func build(notificationService: NotificationServiceInterface) -> ReachabilityServiceInterface {
        let reachabilityService = ReachabilityService()
        reachabilityService.notificationService = notificationService
        reachabilityService.configure()
        return reachabilityService
    }
}
