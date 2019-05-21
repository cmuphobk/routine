import UIKit

final class MainRouter: MainModuleRouting {
    weak var viewController: UIViewController!
    var coordinator: MainCoordinator!
    
    func openCourseModule() {
        
//        self.moduleService.moduleFactory.makeMedicineCourseModule { [unowned self] (_, medicineCourseModuleInput) in
//            guard let module = medicineCourseModuleInput as? Module else { return }
//            self.moduleService.navigation?.pushModule(module)
//        }
        
    }
    
    func rightSwipeAction() {
        self.coordinator.openMenu()
    }
    
    func leftSwipeAction() {
        self.coordinator.hideMenu()
    }
    
    @objc func menuButtonClicked() {
        self.coordinator.triggerMenu()
    }
    
    func configureNavigationBar(title: String) {
        self.coordinator.configureNavigationTitle(title)
        
        self.coordinator.configureNavigationBarWithColor(ColorProvider.default.blueColor)
        
        self.coordinator.customBarLeftButtonAction(
            icon: ImageProvider.default.menuIcon.imageWithMask(color: ColorProvider.default.whiteColor),
            target: self,
            action: #selector(menuButtonClicked))
    }
}
