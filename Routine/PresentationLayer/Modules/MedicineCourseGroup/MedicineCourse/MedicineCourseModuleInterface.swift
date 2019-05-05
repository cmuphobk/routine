
import UIKit

protocol MedicineCourseModuleInput: class {
    func configureModule()
}

protocol MedicineCourseViewInput: class {
    func setupInitialState()
    func updateTableView(models: [MedicineCourse], isArchive: Bool)
    
    func reloadRowAtIndex(_ index: Int, medCourse: MedicineCourse)
    func deleteRowAtIndex(_ index: Int)
    
    func openModal(view: UIView, completion: @escaping (Bool, StandartModalView) -> Void)
    func closeModal(completion: @escaping (Bool) -> Void) 
}

protocol MedicineCourseViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func closeModule()
    
    func didTriggerOpenCreateCourseModal()
    
    func didTriggerSelectMedicineGroupType(_ type: MedicineCourseGroupType)
    
    func rowDidPressed(index: Int)
    func rowDidRenamed(index: Int)
    func rowDidRemoved(index: Int)
}

protocol MedicineCourseModuleRouting: class {
    func openCreateCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleModuleOutput) -> InputTextPopup?
    func openRenameCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleModuleOutput, medCourse: MedicineCourse) -> InputTextPopup?
    func openDeleteCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleModuleOutput) -> ConfirmDecisionPopup?
    func closeEditStandartModal()
    func closeModule()
    func openDrugsList(medCourse: MedicineCourse)
    func containerForModal() -> ModalContainer?
}
