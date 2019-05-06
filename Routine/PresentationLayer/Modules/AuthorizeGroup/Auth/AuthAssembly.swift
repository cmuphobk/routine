import UIKit

enum AuthAssembly {
    
    static func buildAuthScreenModule(_ completion: (UIViewController?, AuthModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.auth.authViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = AuthPresenter()
        let authService = AppDelegate.serviceProvider.makeAuthService()
        let router = AuthRouter()
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
