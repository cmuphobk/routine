import UIKit

final class MainRouter: MainModuleRouting {
    weak var viewController: UIViewController?
    var coordinator: MainCoordinator!
    
    func openCourseModule() {
        
//        self.moduleService.moduleFactory.makeMedicineCourseModule { [unowned self] (_, medicineCourseModuleInput) in
//            guard let module = medicineCourseModuleInput as? Module else { return }
//            self.moduleService.navigation?.pushModule(module)
//        }
        
    }
    
    func rightSwipeAction() {
//        self.moduleService.navigation?.openMenu()
    }
    
    func leftSwipeAction() {
//        self.moduleService.navigation?.hideMenu()
    }
    
    func menuButtonClicked() {
//        self.moduleService.navigation?.triggerMenu()
    }
}
