import UIKit

enum DrugEditMode {
    case create
    case edit
}

enum DrugEditAssembly {
    
    static func buildDrugEditScreenModuleWithModuleOutput(_ moduleOutput: DrugEditModuleOutput?,
                                                          completion: (UIViewController?, DrugEditModuleInput?) -> Void) {
        
        // Creating module components
        guard let moduleViewController = R.storyboard.drugEdit.drugEditViewController() else {
            completion(nil, nil)
            return
        }
                
        let presenter = DrugEditPresenter()
        let router = DrugEditRouter()
        
        // Inject properties
        moduleViewController.output = presenter
        moduleViewController.moduleService = AppDelegate.serviceProvider.makeModuleService()
        
        presenter.view = moduleViewController
        presenter.router = router
        presenter.moduleOutput = moduleOutput
        
        presenter.drugsService = AppDelegate.serviceProvider.makeMedicineDrugService()
        presenter.medicineCourseService = AppDelegate.serviceProvider.makeMedicineCourseService()
        presenter.localNotificationService = AppDelegate.serviceProvider.makeLocalNotificationService()
        
        router.viewController = moduleViewController
        router.viewController = moduleViewController
        router.moduleService = AppDelegate.serviceProvider.makeModuleService()
        
        completion(moduleViewController, presenter)
    }
    
}
