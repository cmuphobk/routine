import Foundation
import UIKit

enum DrugTimesEditAssembly {
    
    static func buildDrugTimesEditScreen(with coordinator: MedicineCourseCoordinator,
                                         moduleOutput: DrugTimesEditModuleOutput?,
                                         completion: (UIViewController?, DrugTimesEditModuleInput?) -> Void) {
        
        // Creating module components
        guard let moduleViewController = R.storyboard.drugTimesEdit.drugTimesEdit() else {
            completion(nil, nil)
            return
        }
        
        let presenter = DrugTimesEditPresenter()
        let router = DrugTimesEditRouter()

        // Inject properties
        moduleViewController.output = presenter
        moduleViewController.moduleService = AppDelegate.serviceProvider.makeModuleService()

        presenter.view = moduleViewController
        presenter.router = router
        presenter.moduleOutput = moduleOutput
        presenter.localizeService = AppDelegate.serviceProvider.makeStringService()

        router.viewController = moduleViewController
        router.viewController = moduleViewController
        router.routerOutput = coordinator
        
        completion(moduleViewController, presenter)
        
    }
    
}
