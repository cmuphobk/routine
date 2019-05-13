import UIKit

enum DrugDetailsAssembly {
    
    static func buildDrugDetailsScreenModuleWithModuleOutput(_ moduleOutput: DrugDetailsModuleOutput?, completion: (UIViewController?, DrugDetailsModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.drugDetails.drugDetailsViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = DrugDetailsPresenter()
        let router = DrugDetailsRouter()
        let moduleService = AppDelegate.serviceProvider.makeModuleService()
        
        // Inject properties
        moduleViewController.output = presenter
        moduleViewController.moduleService = moduleService
        presenter.view = moduleViewController
        presenter.localizeService = AppDelegate.serviceProvider.makeStringService()
        presenter.router = router
        presenter.moduleOutput = moduleOutput
        router.viewController = moduleViewController
        router.moduleService = moduleService
        
        completion(moduleViewController, presenter)
    }
    
}
