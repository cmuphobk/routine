import UIKit

protocol DrugDetailsModuleInput: class {
    func configureModule(medicineCourse: MedicineCourse, drug: MedicineDrug, drugsListModuleInput: DrugsListModuleInput)
}

protocol DrugDetailsModuleOutput: class {
    
}

protocol DrugDetailsViewInput: class {
    func setupInitialState()
    func updateNavTitle(_ text: String)
    func enableEditButton()
    func updateDetailsInfo(htmlCode: String)
}

protocol DrugDetailsViewOutput: class {
    var localizeService: StringServiceInterface! { get }
    
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    
    func editDrugAction()
    
    func didTriggerBackAction()
}

protocol DrugDetailsModuleRouting: class {
    func openDrigEdit(_ drug: MedicineDrug, medCourse: MedicineCourse, drugsListModuleInput: DrugsListModuleInput)
    func closeModule()
}

protocol DrugDetailsModuleAnimating: class {
    
}
