import UIKit

enum DrugsListAssembly {
    
    static func buildDrugsListScreenModule(with coordinator: MedicineCourseCoordinator, moduleOutput: DrugsListModuleOutput?, completion: (UIViewController?, DrugsListModuleInput?) -> Void) {
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
        presenter.localizeService = AppDelegate.serviceProvider.makeStringService()
        presenter.drugsListTableViewFactory = DrugsListTableViewFactoryAssembly.build()
        router.viewController = moduleViewController
        router.routerOutput = coordinator
        
        completion(moduleViewController, presenter)
    }
    
}
