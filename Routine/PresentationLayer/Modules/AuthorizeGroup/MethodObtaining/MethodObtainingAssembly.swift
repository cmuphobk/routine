import UIKit

enum MethodObtainingAssembly {
    
    static func buildMethodObtainingScreenModule(_ completion: (UIViewController?, MethodObtainingModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.methodObtaining.methodObtainingViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = MethodObtainingPresenter()
        let router = MethodObtainingRouter()
        let windowService = AppDelegate.serviceProvider.makeWindowService()
        let moduleService = AppDelegate.serviceProvider.makeModuleService()
        
        // Inject properties
        moduleViewController.output = presenter
        moduleViewController.windowService = windowService
        presenter.view = moduleViewController
        presenter.router = router
        router.viewController = moduleViewController
        router.moduleService = moduleService
        
        completion(moduleViewController, presenter)
    }
    
}
