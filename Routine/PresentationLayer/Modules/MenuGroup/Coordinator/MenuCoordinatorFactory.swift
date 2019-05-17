import UIKit

class MenuCoordinatorFactory {
    
    func makeMenuViewController(with coordinator: MenuCoordinator,
                                completion: (UIViewController?, MenuModuleInput?) -> Void) {
        
        completion(nil, nil)
    }
    
}
