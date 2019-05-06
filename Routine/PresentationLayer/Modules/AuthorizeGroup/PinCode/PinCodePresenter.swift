import UIKit

let kPinCodeModuleId = "pin_code_name"

final class PinCodePresenter: Module {
    weak var view: PinCodeViewInput?
    var router: PinCodeModuleRouting!
    var authService: AuthServiceInterface!
    
    var name = kPinCodeModuleId
    var alias = "pin_code_alias"
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
    
    private var login: String = ""
    private var password: String?
    private var pinCodeInitiator: PinCodeInitiator!
}

// MARK: - PinCodeModuleInput
extension PinCodePresenter: PinCodeModuleInput {
    
    func configureWithLogin(_ login: String, password: String?, pinCodeInitiator: PinCodeInitiator) {
        
        self.login = login
        self.password = password
        self.pinCodeInitiator = pinCodeInitiator
        
    }
    
}

// MARK: - PinCodeViewOutput
extension PinCodePresenter: PinCodeViewOutput {

    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
        self.view?.configureWithLogin(self.login)
    }
    
    func didTriggerViewWillAppear() {
        
    }
    
    func didTriggerCloseModalFromBlurredBackground() {
        self.view?.closeModal { [unowned self] _ in
            self.router.authOpenModule()
        }
    }
    
    func didTriggerCancelButton() {
        self.router.authOpenModule()
    }
    
    func didTriggerResendButton() {
        
        self.router.showLoader()
        self.authService.sendCodeWithModel(CodeRequestModel(login: self.login), completion: { [unowned self] (handler) in
            
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
                self.router.showSuccessMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("pin_success_string"))
            } else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("auth_error_string"))
                self.router.hideLoader()
            }
            
        })
    }
    
    func didTriggerEnterPinCode(_ pinCode: String?) {
        
        guard let pinCode = pinCode else { return }
        
        self.router.showLoader()
        
        self.authService.checkCodeWithModel(CheckCodeRequestModel(login: self.login, code: pinCode)) { [unowned self] (handler) in
            
            guard let handler = handler else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("pin_error_string"))
                self.router.hideLoader()
                return
            }
            
            if let errors = handler.decodeResponse?.errors, errors.count > 0 {
                
                for error in errors {
                    switch error.code {
                    case .incorrectCodeError?:
                        
                        guard let count = error.data?["tryRemain"] else {
                            self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("pin_error_template_string"))
                            self.router.hideLoader()
                            return
                        }
                        let string = count != nil ? String(format: AppDelegate.serviceProvider.makeStringService().localizeById("pin_error_template_count_string"), count!) : AppDelegate.serviceProvider.makeStringService().localizeById("pin_error_template_string")
                        self.router.showErrorMessageWithText(string)
                        self.router.hideLoader()
                        
                    case .needNewCodeError?:
                        //если все плохо и надо снова отпраить код
                        guard let containerForModal = self.router.containerForModal() else {
                            self.router.hideLoader()
                            return
                        }
                        self.router.hideLoader()
                        self.view?.openModal(view: containerForModal.view) { [unowned self] (_, modal) in
                            let errorCodeViewController = self.router.openErrorCodeInStandartModal(modal)
                            errorCodeViewController?.delegate = self
                        }
                        
                    default:
                        self.router.hideLoader()
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("pin_error_string"))
                    }
                    
                }
                
            } else if handler.status == .success {
                
                // если все ок и пошли дальше
                if self.pinCodeInitiator == .register {
                    
                    self.router.hideLoader()
                    self.router.profileOpenModule(login: self.login, password: self.password ?? "")
                    
                } else if self.pinCodeInitiator == .auth {
                    
                    self.router.hideLoader()
                    self.router.authOpenModule()
                    
                } else if self.pinCodeInitiator == .restorePassword {
                    
                    self.router.hideLoader()
                    self.router.openAcceptRestoreModule(login: self.login)
                    
                }
                
            } else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("pin_error_string"))
                self.router.hideLoader()
            }
            
        }
        
    }
    
}

// MARK: - ErrorCodeViewControllerDelegate
extension PinCodePresenter: ErrorCodeViewControllerDelegate {
    
    func didTriggerErrorCodeAcceptButton() {
        self.view?.closeModal { [unowned self] _ in
            self.didTriggerResendButton()
        }
    }
    
    func didTriggerErrorCodeCancelButton() {
        self.router.authOpenModule()
    }

}
