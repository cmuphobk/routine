import UIKit

protocol DrugsListModuleInput: ModuleInput {
    func configureModule(selectedMedCourse: MedicineCourse)
    func updateDrug(_ drug: MedicineDrug)
    func removeDrug(_ drug: MedicineDrug)
}

protocol DrugsListModuleOutput: ModuleOutput {

}

protocol DrugsListViewInput: ViewInput {
    func updateNavTitle(_ text: String)
    func enableCreateButton()
    func updateTableViewWithMedicineCourse(_ medicineCourse: MedicineCourse)
    func updateDrug(_ drug: MedicineDrug, forIndex: Int)
    func removeDrug(_ drug: MedicineDrug, forIndex: Int)
}

protocol DrugsListViewOutput: ViewOutput {
    var localizeService: StringServiceInterface! { get }
    var drugsListTableViewFactory: DrugsListTableViewFactoryInterface! { get }
    
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func createDrugButtonDidPressed()
    func backButtonPressed()
    func rowDidPressed(index: Int)
}

protocol DrugsListRouterInput: RouterInput {
    func openDrugDetails(_ drug: MedicineDrug, medicineCourse: MedicineCourse, drugsListModuleInput: DrugsListModuleInput)
    func openCreateDrugsForCourse(_ medicineCourse: MedicineCourse, drugsListModuleInput: DrugsListModuleInput)
    func closeModule()
}

protocol DrugsListRouterOutput: RouterOutput {
    
}
