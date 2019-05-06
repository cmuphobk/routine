import UIKit

final class AuthRouter: AuthModuleRouting {
    weak var viewController: UIViewController?
    var moduleService: ModuleServiceInterface!
    
    func openMainModule() {
        
        self.moduleService.moduleFactory.makeMainModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            self.moduleService.navigation?.openModule(module)
        }
        
    }
    
    func openMethodObtainingModuleWithPhone(_ phone: String, andEmail email: String) {
        
        self.moduleService.moduleFactory.makeMethodObtainingModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            self.moduleService.navigation?.openModule(module)
            
            moduleInput?.configureModuleWithNumber(phone, andEmail: email)
        }
        
    }
    
    func openPinCodeModule(login: String) {
        
        self.moduleService.moduleFactory.makePinCodeModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            self.moduleService.navigation?.openModule(module)
            
            moduleInput?.configureWithLogin(login, password: nil, pinCodeInitiator: .auth)
        }
        
    }
    
    func openRegistrationModule() {
        
        self.moduleService.moduleFactory.makeRegistrationModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            self.moduleService.navigation?.openModule(module)
        }
        
    }
    
    func openRestorePasswordModule() {
        
        self.moduleService.moduleFactory.makeRestorePasswordModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            self.moduleService.navigation?.openModule(module)
        }
        
    }
    
    func showErrorMessageWithText(_ string: String) {
        
        self.moduleService.navigation?.showMessageWithText(string, andType: .error)
        
    }
    
    func closeModule() {
        
        self.moduleService.navigation?.popModule()
        
    }
    
    func showLoader() {
        
        guard let window = UIApplication.shared.delegate?.window else { return }
        window?.showLoaderView()
        
    }
    
    func hideLoader() {
        
        guard let window = UIApplication.shared.delegate?.window else { return }
        window?.hideLoaderView()
        
    }
}
