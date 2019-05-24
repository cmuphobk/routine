import UIKit

final class MenuRouter: BaseRouter {
    weak var viewController: UIViewController!
    weak var routerOutput: MenuRouterOutput!
}

extension MenuRouter: MenuRouterInput {
    func didTriggerOpenModuleById(_ identifier: String) {
        self.routerOutput.openModuleById(identifier)
    }
    
    func didTriggerShowMenu() {
        self.routerOutput.openMenu()
    }
    
    func didTriggerHideMenu() {
        self.routerOutput.hideMenu()
    }
}
