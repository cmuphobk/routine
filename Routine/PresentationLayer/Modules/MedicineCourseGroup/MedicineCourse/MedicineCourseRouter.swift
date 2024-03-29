import UIKit

final class MedicineCourseRouter: MedicineCourseModuleRouting {
    weak var viewController: UIViewController?
    var moduleService: ModuleServiceInterface!
    
    weak private var createMedicineCourseViewController: InputTextPopup?
    weak private var deleteMedicineCourseViewController: ConfirmDecisionPopup?
    
    func openCreateCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleModuleOutput) -> InputTextPopup? {
        
        self.createMedicineCourseViewController = self.moduleService.moduleFactory.makeCreatePopUpModule(confirmationDelegate: confirmationDelegate)
        guard let createMedicineCourseViewController = self.createMedicineCourseViewController else { return nil }
        
        createMedicineCourseViewController.view.frame = modal.modalContainer.bounds
        createMedicineCourseViewController.view.layer.cornerRadius = modal.modalContainer.layer.cornerRadius
        modal.modalContainer.addSubview(createMedicineCourseViewController.view)
        parentViewController.addChild(createMedicineCourseViewController)
        
        return createMedicineCourseViewController
    }
    
    func openRenameCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleModuleOutput, medCourse: MedicineCourse) -> InputTextPopup? {
        
        self.createMedicineCourseViewController = self.moduleService.moduleFactory.makeRenamePopupModule(confirmationDelegate: confirmationDelegate, medCourse: medCourse)
        guard let createMedicineCourseViewController = self.createMedicineCourseViewController else { return nil }
        
        createMedicineCourseViewController.view.frame = modal.modalContainer.bounds
        createMedicineCourseViewController.view.layer.cornerRadius = modal.modalContainer.layer.cornerRadius
        modal.modalContainer.addSubview(createMedicineCourseViewController.view)
        parentViewController.addChild(createMedicineCourseViewController)
        
        return createMedicineCourseViewController
    }
    
    func openDeleteCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleModuleOutput) -> ConfirmDecisionPopup? {
        
        self.deleteMedicineCourseViewController = self.moduleService.moduleFactory.makeDeletePopupModule(confirmationDelegate: confirmationDelegate)
        guard let deleteMedicineCourseViewController = self.deleteMedicineCourseViewController else { return nil }
        
        deleteMedicineCourseViewController.view.frame = modal.modalContainer.bounds
        deleteMedicineCourseViewController.view.layer.cornerRadius = modal.modalContainer.layer.cornerRadius
        modal.modalContainer.addSubview(deleteMedicineCourseViewController.view)
        parentViewController.addChild(deleteMedicineCourseViewController)
        
        return deleteMedicineCourseViewController
    }
    
    func closeEditStandartModal() {
        
        if let createMedicineCourseViewController = self.createMedicineCourseViewController {
            createMedicineCourseViewController.view.removeFromSuperview()
            createMedicineCourseViewController.removeFromParent()
            self.createMedicineCourseViewController = nil
        }
        
        if let deleteMedicineCourseViewController = self.deleteMedicineCourseViewController {
            deleteMedicineCourseViewController.view.removeFromSuperview()
            deleteMedicineCourseViewController.removeFromParent()
            self.deleteMedicineCourseViewController = nil
        }
        
    }
    
    func closeModule() {
        self.moduleService.moduleFactory.makeMainModule { [unowned self] (_, mainModuleInput) in
            if let module = mainModuleInput as? Module {
                self.moduleService.navigation?.openModuleFromLeft( module )
            }
        }
    }
    
    func openDrugsList(medCourse: MedicineCourse) {
        var module: Module!

        self.moduleService.moduleFactory.makeDrugsListModule(nil) { [unowned medCourse] (_, drugsListModuleInput) in
            module = drugsListModuleInput as? Module
            drugsListModuleInput?.configureModule(selectedMedCourse: medCourse)
        }
        
        self.moduleService.navigation?.pushModule(module)
    }
    
    func containerForModal() -> ModalContainer? {
        return self.moduleService.navigation?.containerForModal()
    }
}
