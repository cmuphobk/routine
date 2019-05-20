import UIKit

final class MenuModuleRouter: MenuModuleRouting {
    weak var viewController: UIViewController?
    var coordinator: MenuCoordinating!
    
    func didTriggerOpenModuleById(_ identifier: String) {
        self.coordinator.openModuleById(identifier)
    }
    
    func didTriggerShowMenu() {
        
    }
    
    func didTriggerHideMenu() {
        
    }
}
