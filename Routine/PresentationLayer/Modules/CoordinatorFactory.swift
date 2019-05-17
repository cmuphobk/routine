import UIKit

class CoordinatorFactory {
    
    func makeMenuCoordinator(navigationController: UINavigationController,
                             flowHandler: FlowHandler<MenuCoordinatorActionType>) -> MenuCoordinator {
        return MenuCoordinator(navigationController: navigationController, flowHandler: flowHandler)
    }
}
