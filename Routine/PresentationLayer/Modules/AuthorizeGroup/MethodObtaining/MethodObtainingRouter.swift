import UIKit

final class MethodObtainingRouter: MethodObtainingModuleRouting {
    weak var viewController: UIViewController?
    var moduleService: ModuleServiceInterface!
    
    func openPinCodeModule(login: String) {
        
        self.moduleService.moduleFactory.makePinCodeModule { [unowned self] (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            self.moduleService.navigation?.openModule(module)
            
            moduleInput?.configureWithLogin(login, password: nil, pinCodeInitiator: .auth)
        }
        
    }
    
    func closeModule() {
    
        self.moduleService.moduleFactory.makeAuthModule { (_, moduleInput) in
            guard let module = moduleInput as? Module else { return }
            self.moduleService.navigation?.openModule(module)
        }
        
    }
}
