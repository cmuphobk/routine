import UIKit

protocol ModuleFactoryInterface {
    
    func makeMenuModule(moduleOutput: MenuModuleOutput, _ completion: (UIViewController?, MenuModuleInput?) -> Void)
    
    func makeMainModule(_ completion: (UIViewController?, MainModuleInput?) -> Void)
        
    func makeMedicineCourseModule(_ completion: (UIViewController?, MedicineCourseModuleInput?) -> Void)
    
    func makeCreatePopUpModule(confirmationDelegate: ConfirmationModuleOutput) -> InputTextPopup?
    
    func makeRenamePopupModule(confirmationDelegate: ConfirmationModuleOutput, medCourse: MedicineCourse) -> InputTextPopup?
    
    func makeDeletePopupModule(confirmationDelegate: ConfirmationModuleOutput) -> ConfirmDecisionPopup?
    
    func makeYesNoPopupModule(confirmationDelegate: ConfirmationModuleOutput, caption: String, text: String, acceptButtonText: String, cancelButtonText: String) -> ConfirmDecisionPopup?
    
    func makeDrugsListModule(_ moduleOutput: DrugsListModuleOutput?, completion: (UIViewController?, DrugsListModuleInput?) -> Void)
    
    func makeDrugsDetailsModule(_ moduleOutput: DrugDetailsModuleOutput?, completion: (UIViewController?, DrugDetailsModuleInput?) -> Void)
    
    func makeDrugsEditModule(_ moduleOutput: DrugEditModuleOutput?, completion: (UIViewController?, DrugEditModuleInput?) -> Void)
    
    func makeDrugTimesEditModule(_ moduleOutput: DrugTimesEditModuleOutput?, completion: (UIViewController?, DrugTimesEditModuleInput?) -> Void)
    
    func makeDrugPeriodicEditModule(_ moduleOutput: DrugPeriodicEditModuleOutput?, completion: (UIViewController?, DrugPeriodicEditModuleInput?) -> Void)

}
