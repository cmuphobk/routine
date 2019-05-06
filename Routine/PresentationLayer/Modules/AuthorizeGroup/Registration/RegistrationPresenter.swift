import UIKit

let kRegistrationModuleId = "registration_name"

final class RegistrationPresenter: Module {
    weak var view: RegistrationViewInput?
    var router: RegistrationModuleRouting!
    var authService: AuthServiceInterface!
    
    var name = kRegistrationModuleId
    var alias = "registration_alias"
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
}

// MARK: - RegistrationModuleInput
extension RegistrationPresenter: RegistrationModuleInput {
    
    func configureModule() {
        
    }
    
}

// MARK: - RegistrationViewOutput
extension RegistrationPresenter: RegistrationViewOutput {

    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
    }
    
    func didTriggerViewWillAppear() {
        
    }
    
    func didTriggerRegistrationButton(login: String, password: String) {
        
        self.router.showLoader()
        self.authService.sendCodeWithModel(CodeRequestModel(login: login)) { [unowned self] (handler) in
            
            guard let handler = handler else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("registration_error_string"))
                self.router.hideLoader()
                return
            }
            
            if let errors = handler.decodeResponse?.errors, errors.count > 0 {
                
                for error in errors {
                    switch error.code {
                    case .incorrectLoginError?:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("incorrectLoginError"))
                        self.router.hideLoader()
                    case .oftenCodeRequestError?:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("oftenCodeRequestError"))
                        self.router.hideLoader()
                    default:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("registration_error_string"))
                        self.router.hideLoader()
                    }
                }
            } else if handler.status == .success {
                self.router.hideLoader()
                self.router.openPinCodeModule(login: login, password: password)
            } else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("registration_error_string"))
                self.router.hideLoader()
            }
            
        }
        
    }
    
    func didTriggerAuthButton() {
        
        self.router.closeModule()
        
    }
    
    func didTriggerOpenLicense() {
        
        self.router.openLicense()
        
    }
    
    func didTriggerOpenMedicine() {
        
        self.router.openMedicine()
        
    }
}
