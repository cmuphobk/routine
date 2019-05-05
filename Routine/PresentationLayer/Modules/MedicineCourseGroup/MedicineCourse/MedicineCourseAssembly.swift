
import UIKit

enum MedicineCourseAssembly {
    
    static func buildMedicineCourseScreenModule(_ completion: (UIViewController?, MedicineCourseModuleInput?) -> Void) {
        // Creating module components
        guard let moduleViewController = R.storyboard.medicineCourse.medicineCourseViewController() else {
            completion(nil, nil)
            return
        }
        let presenter = MedicineCoursePresenter()
        let router = MedicineCourseRouter()
        let medicineCourseService = AppDelegate.serviceProvider.makeMedicineCourseService()
        let moduleService = AppDelegate.serviceProvider.makeModuleService()
        
        // Inject properties
        moduleViewController.output = presenter
        moduleViewController.moduleService = moduleService
        presenter.view = moduleViewController
        presenter.router = router
        presenter.medicineCourseService = medicineCourseService
        router.viewController = moduleViewController
        router.moduleService = moduleService
        
        completion(moduleViewController, presenter)
    }
    
}
