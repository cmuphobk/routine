import UIKit

enum MainAssembly {
    
    static func buildMainScreenModuleWith(coordinator: MainCoordinator, _ completion: (UIViewController?, MainModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.main.mainViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = MainPresenter()
        let router = MainRouter()
        
        // Inject properties
        moduleViewController.output = presenter
        presenter.view = moduleViewController
        presenter.router = router
        presenter.localizeService = AppDelegate.serviceProvider.makeStringService()
        presenter.mainTableViewFactory = MainTableViewFactoryAssembly.build()
        router.viewController = moduleViewController
        router.coordinator = coordinator
        
        completion(moduleViewController, presenter)
    }
    
}
