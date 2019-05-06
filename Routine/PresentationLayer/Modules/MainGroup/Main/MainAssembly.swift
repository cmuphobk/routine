import UIKit

enum MainAssembly {
    
    static func buildMainScreenModule(_ completion: (UIViewController?, MainModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.main.mainViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = MainPresenter()
        let router = MainRouter()
        let moduleService = AppDelegate.serviceProvider.makeModuleService()
        
        // Inject properties
        moduleViewController.output = presenter
        presenter.view = moduleViewController
        presenter.router = router
        router.viewController = moduleViewController
        router.moduleService = moduleService
        
        completion(moduleViewController, presenter)
    }
    
}
