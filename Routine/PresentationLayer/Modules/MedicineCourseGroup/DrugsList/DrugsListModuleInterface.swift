import UIKit

protocol DrugsListModuleInput: class {
    func configureModule(selectedMedCourse: MedicineCourse)
    func updateDrug(_ drug: MedicineDrug)
    func removeDrug(_ drug: MedicineDrug)
}

protocol DrugsListModuleOutput: class {
    // empty
}

protocol DrugsListViewInput: class {
    func setupInitialState()
    func updateNavTitle(_ text: String)
    func enableCreateButton()
    func updateTableViewWithMedicineCourse(_ medicineCourse: MedicineCourse)
    func updateDrug(_ drug: MedicineDrug, forIndex: Int)
    func removeDrug(_ drug: MedicineDrug, forIndex: Int)
}

protocol DrugsListViewOutput: class {
    var localizeService: StringServiceInterface! { get }
    
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func createDrugButtonDidPressed()
    func backButtonPressed()
    func rowDidPressed(index: Int)
}

protocol DrugsListModuleRouting: class {
    func openDrugDetails(_ drug: MedicineDrug, medicineCourse: MedicineCourse, drugsListModuleInput: DrugsListModuleInput)
    func openCreateDrugsForCourse(_ medicineCourse: MedicineCourse, drugsListModuleInput: DrugsListModuleInput)
    func closeModule()
}

protocol DrugsListModuleAnimating: class {
    // empty
}
