import UIKit

final class MenuModuleRouter: MenuModuleRouting {
    weak var viewController: UIViewController!
    var coordinator: ApplicationCoordinating!
    
    func didTriggerOpenModuleById(_ identifier: String) {
        self.coordinator.openModuleById(identifier)
    }
    
    func didTriggerShowMenu() {
        self.coordinator.openMenu()
    }
    
    func didTriggerHideMenu() {
        self.coordinator.hideMenu()
    }
}
