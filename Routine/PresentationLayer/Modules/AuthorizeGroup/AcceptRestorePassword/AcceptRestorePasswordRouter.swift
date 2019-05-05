
import UIKit

final class AcceptRestorePasswordRouter: AcceptRestorePasswordModuleRouting {
    weak var viewController: UIViewController?
    var moduleService: ModuleServiceInterface!
    
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
}
