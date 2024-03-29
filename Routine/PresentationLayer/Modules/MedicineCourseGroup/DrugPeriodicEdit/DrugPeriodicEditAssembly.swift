import Foundation
import UIKit

enum DrugPeriodicEditAssembly {
    
    static func buildDrugPeriodicEditScreenWithModuleOutput(_ moduleOutput: DrugPeriodicEditModuleOutput?, completion: (UIViewController?, DrugPeriodicEditModuleInput?) -> Void) {
        
        // Creating module components
        guard let moduleViewController = R.storyboard.drugPeriodicEdit.drugPeriodicEdit() else {
            completion(nil, nil)
            return
        }
        
        let presenter = DrugPeriodicEditPresenter()
        let router = DrugPeriodicEditRouter()
        
        // Inject properties
        moduleViewController.output = presenter
        moduleViewController.moduleService = AppDelegate.serviceProvider.makeModuleService()
        
        presenter.view = moduleViewController
        presenter.router = router
        presenter.moduleOutput = moduleOutput
        
        router.viewController = moduleViewController
        router.viewController = moduleViewController
        router.moduleService = AppDelegate.serviceProvider.makeModuleService()
        
        completion(moduleViewController, presenter)
        
    }
    
}
