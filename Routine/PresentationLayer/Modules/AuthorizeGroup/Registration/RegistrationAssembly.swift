import UIKit

enum RegistrationAssembly {
    
    static func buildRegistrationScreenModule(_ completion: (UIViewController?, RegistrationModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.registration.registrationViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = RegistrationPresenter()
        let authService = AppDelegate.serviceProvider.makeAuthService()
        let router = RegistrationRouter()
        let windowService = AppDelegate.serviceProvider.makeWindowService()
        let moduleService = AppDelegate.serviceProvider.makeModuleService()
        
        // Inject properties
        moduleViewController.output = presenter
        moduleViewController.windowService = windowService
        presenter.view = moduleViewController
        presenter.router = router
        presenter.authService = authService
        router.viewController = moduleViewController
        router.moduleService = moduleService
        
        completion(moduleViewController, presenter)
    }
    
}
