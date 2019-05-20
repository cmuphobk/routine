import UIKit

class MainCoordinatorFactory {
    
    func makeMainViewController(with coordinator: MainCoordinator,
                                completion: (UIViewController?, MainModuleInput?) -> Void) {
        
        MainAssembly.buildMainScreenModuleWith(coordinator: coordinator, completion)
    }
    
}
