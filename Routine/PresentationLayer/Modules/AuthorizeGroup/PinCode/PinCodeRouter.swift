import UIKit

final class PinCodeRouter: PinCodeModuleRouting {
    weak var viewController: UIViewController?
    var moduleService: ModuleServiceInterface!
    
    func profileOpenModule(login: String, password: String) {
        
        self.moduleService.moduleFactory.makeProfileModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            moduleInput?.configureModule(login: login, password: password)
            self.moduleService.navigation?.openModule(module)
        }
        
    }
    
    func openErrorCodeInStandartModal(_ modal: StandartModalView) -> ErrorCodeViewController? {
        
        guard let errorCodeViewController = R.storyboard.errorCode.errorCodeViewController() else { return nil }
        errorCodeViewController.view.frame = modal.modalContainer.bounds
        modal.modalContainer.addSubview(errorCodeViewController.view)
        self.viewController?.addChild(errorCodeViewController)
        
        return errorCodeViewController
        
    }
    
    func authOpenModule() {
        
        self.moduleService.moduleFactory.makeAuthModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            self.moduleService.navigation?.openModule(module)
        }
        
    }
    
    func openAcceptRestoreModule(login: String) {
        
        self.moduleService.moduleFactory.makeAcceptRestorePasswordModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            moduleInput?.configureModule(login: login)
            
            self.moduleService.navigation?.openModule(module)
        }
        
    }
    
    func showSuccessMessageWithText(_ string: String) {
        
        self.moduleService.navigation?.showMessageWithText(string, andType: .success)
        
    }
    
    func showErrorMessageWithText(_ string: String) {
        
        self.moduleService.navigation?.showMessageWithText(string, andType: .error)
        
    }
    
    func showLoader() {
        
        guard let window = UIApplication.shared.delegate?.window else { return }
        window?.showLoaderView()
        
    }
    
    func hideLoader() {
        
        guard let window = UIApplication.shared.delegate?.window else { return }
        window?.hideLoaderView()
        
    }
    
    func containerForModal() -> ModalContainer? {
        return self.moduleService.navigation?.containerForModal()
    }
    
}
