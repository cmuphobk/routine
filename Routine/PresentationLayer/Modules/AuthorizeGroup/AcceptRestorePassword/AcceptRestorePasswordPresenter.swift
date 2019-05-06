import UIKit

let kAcceptRestorePasswordModuleId = "accept_restore_password_name"

final class AcceptRestorePasswordPresenter: Module {
    weak var view: AcceptRestorePasswordViewInput?
    var router: AcceptRestorePasswordModuleRouting!
    var authService: AuthServiceInterface!
    var authStorage: AuthStorageInterface!
    
    var name = kAcceptRestorePasswordModuleId
    var alias = "accept_restore_password_alias"
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
    
    private var login: String!
}

// MARK: - AcceptRestorePasswordModuleInput
extension AcceptRestorePasswordPresenter: AcceptRestorePasswordModuleInput {
    
    func configureModule(login: String) {
        self.login = login
    }
    
}

// MARK: - AcceptRestorePasswordViewOutput
extension AcceptRestorePasswordPresenter: AcceptRestorePasswordViewOutput {
    
    func didTriggerRestoreButton(password: String) {
        
        self.router.showLoader()
        
        self.authService.recoveryPasswordWithModel(RecoveryPasswordRequestModel(login: self.login, newPassword: password, loginToken: self.authStorage.receiveLoginToken())) { [unowned self] (handler) in
            guard let handler = handler else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("accept_restore_password_error_string"))
                self.router.hideLoader()
                return
            }
            
            if let errors = handler.decodeResponse?.errors, errors.count > 0 {
                
                for error in errors {
                    switch error.code {
                    case .incorrectTokenError?:
                        self.router.hideLoader()
                        self.router.closeModule()
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("accept_restore_password_error_string"))
                    case .loginUnregisterError?:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("accept_restore_password_loginUnregisterError"))
                        self.router.hideLoader()
                    default:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("accept_restore_password_error_string"))
                        self.router.hideLoader()
                    }
                }
            } else if handler.status == .success {
                self.router.hideLoader()
                self.router.closeModule()
            } else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("accept_restore_password_error_string"))
                self.router.hideLoader()
            }
        }
        
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
