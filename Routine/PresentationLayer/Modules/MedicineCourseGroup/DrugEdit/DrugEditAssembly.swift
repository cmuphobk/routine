import UIKit

enum DrugEditMode {
    case create
    case edit
}

enum DrugEditAssembly {
    
    static func buildDrugEditScreenModule(with coordinator: MedicineCourseCoordinator,
                                          moduleOutput: DrugEditModuleOutput?,
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
        presenter.localizeService = AppDelegate.serviceProvider.makeStringService()
        presenter.languageService = AppDelegate.serviceProvider.makeLanguageService()
        presenter.drugEditTableViewFactory = DrugEditTableViewFactoryAssembly.build()
        
        router.viewController = moduleViewController
        router.viewController = moduleViewController
        router.routerOutput = coordinator
        
        completion(moduleViewController, presenter)
    }
    
}
