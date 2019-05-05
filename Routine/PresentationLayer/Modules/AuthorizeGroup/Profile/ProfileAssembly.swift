
import UIKit

enum ProfileAssembly {
    
    static func buildProfileScreenModule(_ completion: (UIViewController?, ProfileModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.profile.profileViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        let authService = AppDelegate.serviceProvider.makeAuthService()
        let authStorage = authService.authStorage
        let windowService = AppDelegate.serviceProvider.makeWindowService()
        let moduleService = AppDelegate.serviceProvider.makeModuleService()
        let notificationService = AppDelegate.serviceProvider.makeNotificationService()
        
        // Inject properties
        moduleViewController.output = presenter
        moduleViewController.windowService = windowService
        moduleViewController.notificationService = notificationService
        presenter.view = moduleViewController
        presenter.router = router
        presenter.authService = authService
        presenter.authStorage = authStorage
        router.viewController = moduleViewController
        router.moduleService = moduleService
        
        completion(moduleViewController, presenter)
    }
    
}
