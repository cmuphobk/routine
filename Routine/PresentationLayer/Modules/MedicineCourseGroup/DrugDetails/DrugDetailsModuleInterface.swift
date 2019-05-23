import UIKit

protocol DrugDetailsModuleInput: ModuleInput {
    func configureModule(medicineCourse: MedicineCourse, drug: MedicineDrug, drugsListModuleInput: DrugsListModuleInput)
}

protocol DrugDetailsModuleOutput: ModuleOutput {
    
}

protocol DrugDetailsViewInput: ViewInput {
    func updateNavTitle(_ text: String)
    func enableEditButton()
    func updateDetailsInfo(htmlCode: String)
}

protocol DrugDetailsViewOutput: ViewOutput {
    var localizeService: StringServiceInterface! { get }
    
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    
    func editDrugAction()
    
    func didTriggerBackAction()
}

protocol DrugDetailsRouterInput: RouterInput {
    func openDrigEdit(_ drug: MedicineDrug, medCourse: MedicineCourse, drugsListModuleInput: DrugsListModuleInput)
    func closeModule()
}

protocol DrugDetailsRouterOutput: RouterOutput {
    
}
