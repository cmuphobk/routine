import UIKit

class ApplicationModuleFactory {
    
    func makeMenuViewController(with coordinator: ApplicationCoordinator,
                                completion: (UIViewController?, MenuModuleInput?) -> Void) {
        
        MenuModuleAssembly.buildMenuModule(with: coordinator, completion)
        
        
    }
    
}
