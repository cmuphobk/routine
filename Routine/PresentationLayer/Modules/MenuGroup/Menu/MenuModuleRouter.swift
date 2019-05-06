import Foundation

final class MenuModuleRouter: MenuModuleRouting {
    
    var moduleService: ModuleServiceInterface!
    
    func didTriggerOpenModuleById(_ identifier: String) {
        
        switch identifier {
        case kMainModuleId:
            
            self.moduleService.moduleFactory.makeMainModule { [unowned self] (_, mainModuleInput) in
                guard let module = mainModuleInput as? Module else { return }
                self.moduleService.navigation?.openModuleFromLeft(module)
                self.moduleService.navigation?.hideMenu()
            }
            
        case kAuthModuleId:
            
            self.moduleService.moduleFactory.makeAuthModule { [unowned self] (_, authModuleInput) in
                guard let module = authModuleInput as? Module else { return }
                self.moduleService.navigation?.openModuleFromLeft(module)
                self.moduleService.navigation?.hideMenu()
            }
            
        case kMedicineCourseModuleId:
            
            self.moduleService.moduleFactory.makeMedicineCourseModule { [unowned self] (_, medicineCourseModuleInput) in
                guard let module = medicineCourseModuleInput as? Module else { return }
                self.moduleService.navigation?.openModuleFromLeft(module)
                self.moduleService.navigation?.hideMenu()
            }
            
            
        default:
            return
        }
        
    }
    
    func didTriggerShowMenu() {
        
    }
    
    func didTriggerHideMenu() {
        
    }
}
