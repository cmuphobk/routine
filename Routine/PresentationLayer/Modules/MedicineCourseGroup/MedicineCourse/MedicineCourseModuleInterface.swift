import UIKit

protocol MedicineCourseModuleInput: ModuleInput {
    func configureModule()
}

protocol MedicineCourseViewInput: ViewInput {
    func updateTableView(models: [MedicineCourse], isArchive: Bool)
    
    func reloadRowAtIndex(_ index: Int, medCourse: MedicineCourse)
    func deleteRowAtIndex(_ index: Int)
    
    func openModal(view: UIView, completion: @escaping (Bool, StandartModalView) -> Void)
    func closeModal(completion: @escaping (Bool) -> Void) 
}

protocol MedicineCourseViewOutput: ViewOutput {
    var localizeService: StringServiceInterface! { get }
    
    var medicineCourseTableViewFactory: MedicineCourseTableViewFactoryInterface! { get }
    
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func closeModule()
    
    func didTriggerOpenCreateCourseModal()
    
    func didTriggerSelectMedicineGroupType(_ type: MedicineCourseGroupType)
    
    func rowDidPressed(index: Int)
    func rowDidRenamed(index: Int)
    func rowDidRemoved(index: Int)
}

protocol MedicineCourseRouterInput: RouterInput {
    func openCreateCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleOutput) -> InputTextPopupViewController?
    func openRenameCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleOutput, medCourse: MedicineCourse) -> InputTextPopupViewController?
    func openDeleteCourseStandartModal(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleOutput) -> ConfirmDecisionPopup?
    func closeEditStandartModal()
    func closeModule()
    func openDrugsList(medCourse: MedicineCourse)
    func containerForModal() -> ModalContainer?
}

protocol MedicineCourseRouterOutput: RouterOutput {
    
}
