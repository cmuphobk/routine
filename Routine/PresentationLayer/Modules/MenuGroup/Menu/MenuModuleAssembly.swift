import UIKit

enum MenuModuleAssembly {
    
    static func buildMenuModule(with coordinator: MenuCoordinator, _ completion: (UIViewController?, MenuModuleInput?) -> Void) {

        // Creating module components
        guard let moduleViewController = R.storyboard.menuModuleViewController.menuModuleViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = MenuModulePresenter()
        let router = MenuModuleRouter()
        
        // Inject properties
        moduleViewController.output = presenter
        presenter.view = moduleViewController
        presenter.router = router
        presenter.localizeService = AppDelegate.serviceProvider.makeStringService()
        presenter.menuTableViewFactory = MenuTableViewFactoryAssembly.build()
        router.coordinator = coordinator
        
        completion(moduleViewController, presenter)
    }
    
}
