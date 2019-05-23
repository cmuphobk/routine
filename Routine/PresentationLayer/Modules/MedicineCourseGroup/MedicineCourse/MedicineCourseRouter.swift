import UIKit

final class MedicineCourseRouter: BaseRouter {
    var routerOutput: MedicineCourseRouterOutput!
    weak var viewController: UIViewController!
}

extension MedicineCourseRouter: MedicineCourseRouterInput {
//    weak private var createMedicineCourseViewController: InputTextPopupViewController?
//    weak private var deleteMedicineCourseViewController: ConfirmDecisionPopup?
    
    func openCreateCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleOutput) -> InputTextPopupViewController? {
        
//        self.createMedicineCourseViewController = self.moduleService.moduleFactory.makeCreatePopUpModule(confirmationDelegate: confirmationDelegate)
//        guard let createMedicineCourseViewController = self.createMedicineCourseViewController else { return nil }
//
//        createMedicineCourseViewController.view.frame = modal.modalContainer.bounds
//        createMedicineCourseViewController.view.layer.cornerRadius = modal.modalContainer.layer.cornerRadius
//        modal.modalContainer.addSubview(createMedicineCourseViewController.view)
//        parentViewController.addChild(createMedicineCourseViewController)
//
//        return createMedicineCourseViewController
        return nil
    }
    
    func openRenameCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleOutput, medCourse: MedicineCourse) -> InputTextPopupViewController? {
        
//        self.createMedicineCourseViewController = self.moduleService.moduleFactory.makeRenamePopupModule(confirmationDelegate: confirmationDelegate, medCourse: medCourse)
//        guard let createMedicineCourseViewController = self.createMedicineCourseViewController else { return nil }
//
//        createMedicineCourseViewController.view.frame = modal.modalContainer.bounds
//        createMedicineCourseViewController.view.layer.cornerRadius = modal.modalContainer.layer.cornerRadius
//        modal.modalContainer.addSubview(createMedicineCourseViewController.view)
//        parentViewController.addChild(createMedicineCourseViewController)
//
//        return createMedicineCourseViewController
        return nil
    }
    
    func openDeleteCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleOutput) -> ConfirmDecisionPopup? {
        
//        self.deleteMedicineCourseViewController = self.moduleService.moduleFactory.makeDeletePopupModule(confirmationDelegate: confirmationDelegate)
//        guard let deleteMedicineCourseViewController = self.deleteMedicineCourseViewController else { return nil }
//
//        deleteMedicineCourseViewController.view.frame = modal.modalContainer.bounds
//        deleteMedicineCourseViewController.view.layer.cornerRadius = modal.modalContainer.layer.cornerRadius
//        modal.modalContainer.addSubview(deleteMedicineCourseViewController.view)
//        parentViewController.addChild(deleteMedicineCourseViewController)
//
//        return deleteMedicineCourseViewController
        return nil
    }
    
    func closeEditStandartModal() {
        
//        if let createMedicineCourseViewController = self.createMedicineCourseViewController {
//            createMedicineCourseViewController.view.removeFromSuperview()
//            createMedicineCourseViewController.removeFromParent()
//            self.createMedicineCourseViewController = nil
//        }
//
//        if let deleteMedicineCourseViewController = self.deleteMedicineCourseViewController {
//            deleteMedicineCourseViewController.view.removeFromSuperview()
//            deleteMedicineCourseViewController.removeFromParent()
//            self.deleteMedicineCourseViewController = nil
//        }
//
    }
    
    func closeModule() {
//        self.moduleService.moduleFactory.makeMainModule { [unowned self] (_, mainModuleInput) in
//            if let module = mainModuleInput as? Module {
//                self.moduleService.navigation?.openModuleFromLeft( module )
//            }
//        }
    }
    
    func openDrugsList(medCourse: MedicineCourse) {
//        var module: Module!
//
//        self.moduleService.moduleFactory.makeDrugsListModule(nil) { [unowned medCourse] (_, drugsListModuleInput) in
//            module = drugsListModuleInput as? Module
//            drugsListModuleInput?.configureModule(selectedMedCourse: medCourse)
//        }
//
//        self.moduleService.navigation?.pushModule(module)
    }
    
    func containerForModal() -> ModalContainer? {
//        return self.moduleService.navigation?.containerForModal()
        let vc = UIViewController()
        return ModalContainer(view: vc.view, viewController: vc)
    }
    
    func setupBarButtons() {
        
    }
}
