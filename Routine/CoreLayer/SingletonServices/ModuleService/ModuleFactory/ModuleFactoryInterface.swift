import UIKit

protocol ModuleFactoryInterface {
    
    func makeMenuModule(moduleOutput: MenuModuleOutput, _ completion: (UIViewController?, MenuModuleInput?) -> Void)
    
    func makeMainModule(_ completion: (UIViewController?, MainModuleInput?) -> Void)
    
    func makeAuthModule(_ completion: (UIViewController?, AuthModuleInput?) -> Void)
    
    func makeMedicineCourseModule(_ completion: (UIViewController?, MedicineCourseModuleInput?) -> Void)
    
    func makePinCodeModule(_ completion: (UIViewController?, PinCodeModuleInput?) -> Void)
    
    func makeMethodObtainingModule(_ completion: (UIViewController?, MethodObtainingModuleInput?) -> Void)
    
    func makeProfileModule(_ completion: (UIViewController?, ProfileModuleInput?) -> Void)
    
    func makeRegistrationModule(_ completion: (UIViewController?, RegistrationModuleInput?) -> Void)
    
    func makeRestorePasswordModule(_ completion: (UIViewController?, RestorePasswordModuleInput?) -> Void)
    
    func makeAcceptRestorePasswordModule(_ completion: (UIViewController?, AcceptRestorePasswordModuleInput?) -> Void) 
    
    func makeCreatePopUpModule(confirmationDelegate: ConfirmationModuleModuleOutput) -> InputTextPopup?
    
    func makeRenamePopupModule(confirmationDelegate: ConfirmationModuleModuleOutput, medCourse: MedicineCourse) -> InputTextPopup?
    
    func makeDeletePopupModule(confirmationDelegate: ConfirmationModuleModuleOutput) -> ConfirmDecisionPopup?
    
    func makeYesNoPopupModule(confirmationDelegate: ConfirmationModuleModuleOutput, caption: String, text: String, acceptButtonText: String, cancelButtonText: String) -> ConfirmDecisionPopup?
    
    func makeDrugsListModule(_ moduleOutput: DrugsListModuleOutput?, completion: (UIViewController?, DrugsListModuleInput?) -> Void)
    
    func makeDrugsDetailsModule(_ moduleOutput: DrugDetailsModuleOutput?, completion: (UIViewController?, DrugDetailsModuleInput?) -> Void)
    
    func makeDrugsEditModule(_ moduleOutput: DrugEditModuleOutput?, completion: (UIViewController?, DrugEditModuleInput?) -> Void)
    
    func makeDrugTimesEditModule(_ moduleOutput: DrugTimesEditModuleOutput?, completion: (UIViewController?, DrugTimesEditModuleInput?) -> Void)
    
    func makeDrugPeriodicEditModule(_ moduleOutput: DrugPeriodicEditModuleOutput?, completion: (UIViewController?, DrugPeriodicEditModuleInput?) -> Void)

}
