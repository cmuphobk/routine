import UIKit

let kAuthModuleId = "auth_name"
let kAuthModuleAlias = "auth_alias"

final class AuthPresenter: Module {
    weak var view: AuthViewInput?
    var router: AuthModuleRouting!
    var authService: AuthServiceInterface!
    
    var name = kAuthModuleId
    var alias = kAuthModuleAlias
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
    
    private var login: String!
    private var password: String!

}

// MARK: - AuthModuleInput
extension AuthPresenter: AuthModuleInput {
    
    func configureModule() {
        
    }
    
}

// MARK: - AuthViewOutput
extension AuthPresenter: AuthViewOutput {

    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
        
        self.authService.deauthorize()
        
    }
    
    func didTriggerViewWillAppear() {
        
    }
    
    func didTriggerSetLogin(_ login: String) {
        
        self.login = login
        
    }
    
    func didTriggerSetPassword(_ password: String) {
        
        self.password = password
        
    }
    
    func didTriggerEnterButtonAction() {
        
        self.router.showLoader()
        
        let authModel = AuthRequestModel(login: self.login ?? "", password: self.password ?? "")
        self.authService.authentificateWithAuthModel(authModel) { [unowned self] (handler) in
            
            guard let handler = handler else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string"))
                self.router.hideLoader()
                return
            }
            
            if let errors = handler.decodeResponse?.errors, errors.count > 0 {
                
                for error in errors {
                    if error.code == .needAcceptLoginError {
                        
                        guard let data = error.data else {
                            self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string"))
                            self.router.hideLoader()
                            return
                        }
                        guard let email = data["email"] else {
                            self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string"))
                            self.router.hideLoader()
                            return
                        }
                        guard let phone = data["phone"] else {
                            self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string"))
                            self.router.hideLoader()
                            return
                        }
                        
                        if (phone != nil && email == nil) || (phone == nil && email != nil) {
                           
                            var login: String!
                            if phone != nil && email == nil {
                                login = phone!
                            } else if phone == nil && email != nil {
                                login = email!
                            }
                            self.authService.sendCodeWithModel(CodeRequestModel(login: login), completion: { [unowned self] (handler) in
                                
                                guard let handler = handler else {
                                    self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string"))
                                    self.router.hideLoader()
                                    return
                                }
                                
                                if let errors = handler.decodeResponse?.errors, errors.count > 0 {
                                    for error in errors {
                                        switch error.code {
                                        case .incorrectLoginError?:
                                            self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("incorrectLoginError"))
                                            self.router.hideLoader()
                                        case .incorrectPasswordError?:
                                            self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("incorrectPasswordError"))
                                            self.router.hideLoader()
                                        case .oftenCodeRequestError?:
                                            self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("oftenCodeRequestError"))
                                            self.router.hideLoader()
                                        default:
                                            self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string"))
                                            self.router.hideLoader()
                                        }
                                    }
                                } else if handler.status == .success {
                                    self.router.hideLoader()
                                    self.router.openPinCodeModule(login: login)
                                } else {
                                    self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string"))
                                    self.router.hideLoader()
                                }
                                
                            })
                            
                        } else {
                            
                            self.router.openMethodObtainingModuleWithPhone(phone!, andEmail: email!)
                            self.router.hideLoader()
                            
                        }
                        
                    } else if error.code == .incorrectLoginPasswordError {
                        
                        guard let count = error.data?["TryRemain"] else {
                            self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("error_credentials_string"))
                            self.router.hideLoader()
                            return
                        }
                        let string = count != nil ? String(format: AppDelegate.serviceProvider.makeStringService().localizeById("error_credentials_count_string"), count!) : AppDelegate.serviceProvider.makeStringService().localizeById("error_credentials_string")
                        self.router.showErrorMessageWithText(string)
                        self.router.hideLoader()
                        
                    } else if error.code == .blockLoginError {
                        
                        guard let seconds = error.data?["timeRemain"] else {
                            self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string"))
                            self.router.hideLoader()
                            return
                        }
                        
                        let string = seconds != nil ? String(format: AppDelegate.serviceProvider.makeStringService().localizeById("error_block_login_string"), seconds!) : AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string")
                        self.router.showErrorMessageWithText(string)
                        self.router.hideLoader()
                        
                    } else {
                        
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string"))
                        self.router.hideLoader()
                        
                    }
                }
            } else if handler.status == .success {
                
                self.router.hideLoader()
                self.router.openMainModule()
                
            } else {
                
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string"))
                self.router.hideLoader()
                
            }
            
        }
        
    }
    
    func didTriggerRegistrationButtonAction() {
        
        self.router.openRegistrationModule()
        
    }
    
    func didTriggerForgotButtonAction() {
        
        self.router.openRestorePasswordModule()
        
    }
}
