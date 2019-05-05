
import UIKit

enum PinCodeAssembly {
    
    static func buildPinCodeScreenModule(_ completion: (UIViewController?, PinCodeModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.pinCode.pinCodeViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = PinCodePresenter()
        let authService = AppDelegate.serviceProvider.makeAuthService()
        let windowService = AppDelegate.serviceProvider.makeWindowService()
        let moduleService = AppDelegate.serviceProvider.makeModuleService()
        let router = PinCodeRouter()
        let notificationService = AppDelegate.serviceProvider.makeNotificationService()
        
        // Inject properties
        moduleViewController.output = presenter
        moduleViewController.windowService = windowService
        moduleViewController.notificationService = notificationService
        presenter.view = moduleViewController
        presenter.router = router
        presenter.authService = authService
        router.viewController = moduleViewController
        router.moduleService = moduleService
        
        completion(moduleViewController, presenter)
    }
    
}
