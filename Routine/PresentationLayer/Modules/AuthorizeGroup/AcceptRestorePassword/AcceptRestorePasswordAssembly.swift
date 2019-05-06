import UIKit

enum AcceptRestorePasswordAssembly {
    
    static func buildAcceptRestorePasswordScreenModule(_ completion: (UIViewController?, AcceptRestorePasswordModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.acceptRestorePassword.acceptRestorePasswordViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = AcceptRestorePasswordPresenter()
        let router = AcceptRestorePasswordRouter()
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
