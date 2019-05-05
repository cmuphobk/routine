
import UIKit

enum RestorePasswordAssembly {
    
    static func buildRestorePasswordScreenModule(_ completion: (UIViewController?, RestorePasswordModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.restorePassword.restorePasswordViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = RestorePasswordPresenter()
        let authService = AppDelegate.serviceProvider.makeAuthService()
        let router = RestorePasswordRouter()
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
        router.moduleService = moduleService
        
        completion(moduleViewController, presenter)
    }
    
}
