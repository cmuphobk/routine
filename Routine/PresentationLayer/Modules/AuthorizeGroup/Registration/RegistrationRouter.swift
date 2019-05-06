import UIKit

final class RegistrationRouter: RegistrationModuleRouting {
    weak var viewController: UIViewController?
    var moduleService: ModuleServiceInterface!
    
    func profileOpenModule(login: String, password: String) {

        self.moduleService.moduleFactory.makeProfileModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            moduleInput?.configureModule(login: login, password: password)
            self.moduleService.navigation?.openModule(module)
        }
        
    }
    
    func openPinCodeModule(login: String, password: String) {
        
        self.moduleService.moduleFactory.makePinCodeModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            self.moduleService.navigation?.pushModule(module)
            
            moduleInput?.configureWithLogin(login, password: password, pinCodeInitiator: .register)
        }
        
    }
    
    func showErrorMessageWithText(_ string: String) {
        
        self.moduleService.navigation?.showMessageWithText(string, andType: .error)
        
    }
    
    func closeModule() {
        
        self.moduleService.moduleFactory.makeAuthModule { [unowned self] (_, moduleInput) in
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
    
    func openLicense() {
        
        guard let url = URL(string: "http://routineapi.ru/user_agreement/") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func openMedicine() {
        
        guard let url = URL(string: "http://routineapi.ru/medical_intervention/") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
