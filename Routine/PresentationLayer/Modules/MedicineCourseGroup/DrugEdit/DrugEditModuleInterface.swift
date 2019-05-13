import UIKit

protocol DrugEditModuleInput: class {
    func configureModule(medicineCourse: MedicineCourse, drug: MedicineDrug?, editMode: DrugEditMode, drugsListModuleInput: DrugsListModuleInput?)
}

protocol DrugEditModuleOutput: class {
    // empty
}

protocol DrugEditViewInput: class {
    func setupInitialState(editMode: DrugEditMode)
    func updateNavTitle(_ text: String)
    
    func updateTableView(model: MedicineDrug?, editMode: DrugEditMode)
    func updateDrugType(_ type: MedicineType?)
    func updateDrugUnit(_ type: MedicineUnit?)
    func updateStartDate(_ date: Date)
    func updateEndingTime(_ value: String)
    func updatePeriodTime(_ value: String)
    
    func openModal(view: UIView, completion: @escaping (Bool, StandartModalView) -> Void)
    func closeModal(completion: @escaping (Bool) -> Void) 
}

protocol DrugEditViewOutput: class {
    var localizeService: StringServiceInterface! { get }
    var languageService: LanguageServiceInterface! { get }
    var drugEditTableViewFactory: DrugEditTableViewFactoryInterface! { get }
    
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func closeModule()
    func deleteButtonAction()
    
    func drugNameChanged(_ newValue: String)
    func drugTypeChanged(_ index: Int)
    func drugUnitChanged(_ index: Int)
    func startDateChanged(_ date: Date)
    func usageTimeChanged(index: Int, date: Date)
    func usageTimeChanged(index: Int, value: Double)
    func drugCommentChanged(_ newText: String)
    func usageTimeAdd()
    
    func rowDidPressed(index: Int)
    func acceptDrug()
    
    func endUsingDidPressed()
    func periodicDidPressed()
    
    func obtainTypeList() -> [SimpleComboboxUnit]
    func obtainUnitList() -> [SimpleComboboxUnit]
}

protocol DrugEditModuleRouting: class {
    func closeModule()
    func closeModuleWithEditMode(_ mode: DrugEditMode)
    
    func openEndUsageEditScreen(moduleOutput: DrugTimesEditModuleOutput)
    func openPeriodicEditScreen(moduleOutput: DrugPeriodicEditModuleOutput, periodType: PeriodCourseType, periodValue: Int)
    
    func deleteQuestionPopup(_ modal: StandartModalView, parentViewController: UIViewController, confirmationDelegate: ConfirmationModuleOutput) -> ConfirmDecisionPopup?
    func closeStandartModal()
    
    func showMessageWithText(_ text: String)
    
    func containerForModal() -> ModalContainer?
}

protocol DrugEditModuleAnimating: class {
    // empty
}
