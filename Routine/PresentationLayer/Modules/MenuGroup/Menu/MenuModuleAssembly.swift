import UIKit

enum MenuModuleAssembly {
    
    static func buildMenuModuleWithModuleOutput(moduleOutput: MenuModuleOutput, _ completion: (UIViewController?, MenuModuleInput?) -> Void) {
        
        // Creating module components
        guard let moduleViewController = R.storyboard.menuModuleViewController.menuModuleViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = MenuModulePresenter()
        let moduleService = AppDelegate.serviceProvider.makeModuleService()
        let router = MenuModuleRouter()
        
        // Inject properties
        moduleViewController.output = presenter
        presenter.moduleOutput = moduleOutput
        presenter.view = moduleViewController
        presenter.router = router
        presenter.localizeService = AppDelegate.serviceProvider.makeStringService()
        presenter.menuTableViewFactory = MenuTableViewFactoryAssembly.build()
        router.moduleService = moduleService
        
        completion(moduleViewController, presenter)
    }
    
}
