import UIKit

final class RestorePasswordRouter: RestorePasswordModuleRouting {
    weak var viewController: UIViewController?
    var moduleService: ModuleServiceInterface!
    
    func openPinCodeModule(login: String) {
        
        self.moduleService.moduleFactory.makePinCodeModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            self.moduleService.navigation?.pushModule(module)
            
            moduleInput?.configureWithLogin(login, password: nil, pinCodeInitiator: .restorePassword)
        }
        
    }
    
    func showErrorMessageWithText(_ string: String) {
        
        self.moduleService.navigation?.showMessageWithText(string, andType: .error)
        
    }
    
    func closeModule() {
        
        self.moduleService.moduleFactory.makeAuthModule { (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            self.moduleService.navigation?.openModule(module)
        }
        
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
