import UIKit

final class DrugsListRouter: DrugsListModuleRouting {
    weak var viewController: UIViewController!
    var coordinator: MedicineCourseCoordinator!
    
    func openDrugDetails(_ drug: MedicineDrug, medicineCourse: MedicineCourse, drugsListModuleInput: DrugsListModuleInput) {
//        var module: Module?
//
//        self.moduleService.moduleFactory.makeDrugsDetailsModule(nil) { [unowned drug, unowned medicineCourse, unowned drugsListModuleInput] (_, moduleInput) in
//            module = moduleInput as? Module
//            moduleInput?.configureModule(medicineCourse: medicineCourse, drug: drug, drugsListModuleInput: drugsListModuleInput)
//        }
//
//        if let module = module {
//            self.moduleService.navigation?.pushModule(module)
//        }
    }
    
    func openCreateDrugsForCourse(_ medicineCourse: MedicineCourse, drugsListModuleInput: DrugsListModuleInput) {
//        var module: Module?
//        
//        self.moduleService.moduleFactory.makeDrugsEditModule(nil) { [unowned medicineCourse, unowned drugsListModuleInput] (_, moduleInput) in
//            module = moduleInput as? Module
//            moduleInput?.configureModule(medicineCourse: medicineCourse, drug: nil, editMode: .create, drugsListModuleInput: drugsListModuleInput)
//        }
//        
//        if let module = module {
//            self.moduleService.navigation?.pushModule(module)
//        }
    }
    
    func closeModule() {
//        self.moduleService.navigation?.popModule()
    }
}
