import UIKit

class MenuCoordinatorFactory {
    
    func makeMenuViewController(with coordinator: MenuCoordinator,
                                completion: (UIViewController?, MenuModuleInput?) -> Void) {
        
        MenuModuleAssembly.buildMenuModule(with: coordinator, completion)
        
        
    }
    
}
