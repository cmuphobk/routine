import UIKit

final class ModuleFactory: ModuleFactoryInterface {

    func makeMenuModule(moduleOutput: MenuModuleOutput, _ completion: (UIViewController?, MenuModuleInput?) -> Void) {
        MenuModuleAssembly.buildMenuModuleWithModuleOutput(moduleOutput: moduleOutput, completion)
    }
    
    func makeMainModule(_ completion: (UIViewController?, MainModuleInput?) -> Void) {
        MainAssembly.buildMainScreenModule(completion)
    }
    
    func makeAuthModule(_ completion: (UIViewController?, AuthModuleInput?) -> Void) {
        AuthAssembly.buildAuthScreenModule(completion)
    }
    
    func makeMedicineCourseModule(_ completion: (UIViewController?, MedicineCourseModuleInput?) -> Void) {
        MedicineCourseAssembly.buildMedicineCourseScreenModule(completion)
    }
    
    func makePinCodeModule(_ completion: (UIViewController?, PinCodeModuleInput?) -> Void) {
        PinCodeAssembly.buildPinCodeScreenModule(completion) 
    }
    func makeMethodObtainingModule(_ completion: (UIViewController?, MethodObtainingModuleInput?) -> Void) {
        MethodObtainingAssembly.buildMethodObtainingScreenModule(completion)
    }
    
    func makeProfileModule(_ completion: (UIViewController?, ProfileModuleInput?) -> Void) {
        ProfileAssembly.buildProfileScreenModule(completion)
    }
    
    func makeRegistrationModule(_ completion: (UIViewController?, RegistrationModuleInput?) -> Void) {
        RegistrationAssembly.buildRegistrationScreenModule(completion)
    }
    
    func makeRestorePasswordModule(_ completion: (UIViewController?, RestorePasswordModuleInput?) -> Void) {
        RestorePasswordAssembly.buildRestorePasswordScreenModule(completion)
    }
    
    func makeAcceptRestorePasswordModule(_ completion: (UIViewController?, AcceptRestorePasswordModuleInput?) -> Void) {
        AcceptRestorePasswordAssembly.buildAcceptRestorePasswordScreenModule(completion)
    }
    
    func makeCreatePopUpModule(confirmationDelegate: ConfirmationModuleModuleOutput) -> InputTextPopup? {
        return ConfirmationModuleAssembly.buildCourseCreatePopup(confirmationDelegate: confirmationDelegate)
    }
    
    func makeRenamePopupModule(confirmationDelegate: ConfirmationModuleModuleOutput, medCourse: MedicineCourse) -> InputTextPopup? {
        return ConfirmationModuleAssembly.buildCourseRenamePopup(confirmationDelegate: confirmationDelegate, medCourse: medCourse)
    }
    
    func makeDeletePopupModule(confirmationDelegate: ConfirmationModuleModuleOutput) -> ConfirmDecisionPopup? {
        return ConfirmationModuleAssembly.buildCourseDeletePopup(confirmationDelegate: confirmationDelegate)
    }
    
    func makeYesNoPopupModule(confirmationDelegate: ConfirmationModuleModuleOutput, caption: String, text: String, acceptButtonText: String, cancelButtonText: String) -> ConfirmDecisionPopup? {
        return ConfirmationModuleAssembly.buildYesNoPopup(confirmationDelegate: confirmationDelegate, caption: caption, text: text, acceptButtonText: acceptButtonText, cancelButtonText: cancelButtonText)
    }
    
    func makeDrugsListModule(_ moduleOutput: DrugsListModuleOutput?, completion: (UIViewController?, DrugsListModuleInput?) -> Void) {
        DrugsListAssembly.buildDrugsListScreenModuleWithModuleOutput(moduleOutput, completion: completion)
    }
    
    func makeDrugsDetailsModule(_ moduleOutput: DrugDetailsModuleOutput?, completion: (UIViewController?, DrugDetailsModuleInput?) -> Void) {
        DrugDetailsAssembly.buildDrugDetailsScreenModuleWithModuleOutput(moduleOutput, completion: completion)
    }
    
    func makeDrugsEditModule(_ moduleOutput: DrugEditModuleOutput?, completion: (UIViewController?, DrugEditModuleInput?) -> Void) {
        DrugEditAssembly.buildDrugEditScreenModuleWithModuleOutput(moduleOutput, completion: completion)
    }
    
    func makeDrugTimesEditModule(_ moduleOutput: DrugTimesEditModuleOutput?, completion: (UIViewController?, DrugTimesEditModuleInput?) -> Void) {
        DrugTimesEditAssembly.buildDrugTimesEditScreenWithModuleOutput(moduleOutput, completion: completion)
    }
    
    func makeDrugPeriodicEditModule(_ moduleOutput: DrugPeriodicEditModuleOutput?, completion: (UIViewController?, DrugPeriodicEditModuleInput?) -> Void) {
        DrugPeriodicEditAssembly.buildDrugPeriodicEditScreenWithModuleOutput(moduleOutput, completion: completion)
    }

}
