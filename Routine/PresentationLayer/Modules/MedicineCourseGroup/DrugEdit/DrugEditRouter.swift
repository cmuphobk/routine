import UIKit

final class DrugEditRouter: DrugEditModuleRouting {
    weak var viewController: UIViewController?
    var moduleService: ModuleServiceInterface!
    
    weak private var deleteQuestionPopupViewController: ConfirmDecisionPopup?
    
    func closeModule() {
        self.moduleService.navigation?.popModule()
    }
    
    func closeModuleWithEditMode(_ mode: DrugEditMode) {
        switch mode {
        case .create:
            self.moduleService.navigation?.popModule()
        case .edit:
            self.moduleService.navigation?.popModule(2)
        }
    }
    
    func openEndUsageEditScreen(moduleOutput: DrugTimesEditModuleOutput) {
        var module: Module?
        
        self.moduleService.moduleFactory.makeDrugTimesEditModule(moduleOutput) { (_, moduleInput) in
            module = moduleInput as? Module
        }
        
        if let module = module {
            self.moduleService.navigation?.pushModule(module)
        }
    }
    
    func openPeriodicEditScreen(moduleOutput: DrugPeriodicEditModuleOutput, periodType: PeriodCourseType, periodValue: Int) {
        var module: Module?
        
        self.moduleService.moduleFactory.makeDrugPeriodicEditModule(moduleOutput) { (_, moduleInput) in
            module = moduleInput as? Module
            moduleInput?.configureModule(periodType: periodType, periodValue: periodValue)
        }
        
        if let module = module {
            self.moduleService.navigation?.pushModule(module)
        }
    }
    
    func deleteQuestionPopup(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleModuleOutput) -> ConfirmDecisionPopup? {
        
        self.deleteQuestionPopupViewController = self.moduleService.moduleFactory.makeYesNoPopupModule(confirmationDelegate: confirmationDelegate, caption: "drug_edit_delete_title", text: "drug_edit_delete_message", acceptButtonText: "drug_edit_delete_confirm", cancelButtonText: "drug_edit_delete_cancel")
        
        guard let deleteQuestionPopupViewController = self.deleteQuestionPopupViewController else { return nil }

        deleteQuestionPopupViewController.view.frame = modal.modalContainer.bounds
        deleteQuestionPopupViewController.view.layer.cornerRadius = modal.modalContainer.layer.cornerRadius
        modal.modalContainer.addSubview(deleteQuestionPopupViewController.view)
        parentViewController.addChild(deleteQuestionPopupViewController)

        return deleteQuestionPopupViewController
    }
    
    func closeStandartModal() {
        
        if let deleteQuestionPopupViewController = self.deleteQuestionPopupViewController {
            deleteQuestionPopupViewController.view.removeFromSuperview()
            deleteQuestionPopupViewController.removeFromParent()
            self.deleteQuestionPopupViewController = nil
        }
    }
    
    func showMessageWithText(_ text: String) {
        self.moduleService.navigation?.showMessageWithText(text, andType: .error)
    }
    
    func containerForModal() -> ModalContainer? {
        return self.moduleService.navigation?.containerForModal()
    }
    
}
