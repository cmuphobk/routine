import UIKit

let kRestorePasswordModuleId = "restore_password_name"

final class RestorePasswordPresenter: Module {
    weak var view: RestorePasswordViewInput?
    var router: RestorePasswordModuleRouting!
    var authService: AuthServiceInterface!
    
    var name = kRestorePasswordModuleId
    var alias = "restore_password_alias"
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
}

// MARK: - RestorePasswordModuleInput
extension RestorePasswordPresenter: RestorePasswordModuleInput {
    
    func configureModule() {
        
    }
    
}

// MARK: - RestorePasswordViewOutput
extension RestorePasswordPresenter: RestorePasswordViewOutput {
    
    func didTriggerRestoreButtonWithLogin(_ login: String) {
        
        self.router.showLoader()
        
        self.authService.sendCodeWithModel(CodeRequestModel(login: login)) { [unowned self] (handler) in
            
            guard let handler = handler else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("restore_password_error_string"))
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
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("restore_password_error_string"))
                        self.router.hideLoader()
                    }
                }
            } else if handler.status == .success {
                self.router.hideLoader()
                self.router.openPinCodeModule(login: login)
            } else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("restore_password_error_string"))
                self.router.hideLoader()
            }
            
        }
        
        //self.router.openAcceptRestoreModule()
        
    }
    
    func didTriggerCancelButton() {
        
        self.router.closeModule()
        
    }

    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
    }
    
    func didTriggerViewWillAppear() {
        
    }
    
}
