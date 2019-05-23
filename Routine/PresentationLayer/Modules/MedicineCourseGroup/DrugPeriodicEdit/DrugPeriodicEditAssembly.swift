import Foundation
import UIKit

enum DrugPeriodicEditAssembly {
    
    static func buildDrugPeriodicEditScreen(with coordinator: MedicineCourseCoordinator, moduleOutput: DrugPeriodicEditModuleOutput?, completion: (UIViewController?, DrugPeriodicEditModuleInput?) -> Void) {
        
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
        presenter.localizeService = AppDelegate.serviceProvider.makeStringService()
        presenter.drugPeriodicEditTableViewFactory = DrugPeriodicEditTableViewFactoryAssembly.build()
        
        router.viewController = moduleViewController
        router.viewController = moduleViewController
        router.routerOutput = coordinator
        
        completion(moduleViewController, presenter)
        
    }
    
}
