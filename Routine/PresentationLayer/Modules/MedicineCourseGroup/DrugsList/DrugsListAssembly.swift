import UIKit

enum DrugsListAssembly {
    
    static func buildDrugsListScreenModuleWithModuleOutput(_ moduleOutput: DrugsListModuleOutput?, completion: (UIViewController?, DrugsListModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.drugsList.drugsListViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = DrugsListPresenter()
        let router = DrugsListRouter()
        let moduleService = AppDelegate.serviceProvider.makeModuleService()
        
        // Inject properties
        moduleViewController.output = presenter
        moduleViewController.moduleService = moduleService
        presenter.view = moduleViewController
        presenter.router = router
        presenter.moduleOutput = moduleOutput
        router.viewController = moduleViewController
        router.moduleService = moduleService
        
        completion(moduleViewController, presenter)
    }
    
}
