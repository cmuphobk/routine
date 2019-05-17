import UIKit

final class DrugDetailsRouter: DrugDetailsModuleRouting {
    weak var viewController: UIViewController?
    var moduleService: ModuleServiceInterface!
    
    func openDrigEdit(_ drug: MedicineDrug, medCourse: MedicineCourse, drugsListModuleInput: DrugsListModuleInput) {
        var module: Module?
        
        self.moduleService.moduleFactory.makeDrugsEditModule(nil) { [unowned drug, unowned medCourse, unowned drugsListModuleInput] (_, moduleInput) in
            module = moduleInput as? Module
            moduleInput?.configureModule(medicineCourse: medCourse, drug: drug, editMode: .edit, drugsListModuleInput: drugsListModuleInput)
        }
        
        if let module = module {
//            self.moduleService.navigation?.pushModule(module)
        }
    }
    
    func closeModule() {
//        self.moduleService.navigation?.popModule()
    }
}
