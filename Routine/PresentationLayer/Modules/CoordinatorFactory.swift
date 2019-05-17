import UIKit

class CoordinatorFactory {
    
    func makeMenuCoordinator(navigationController: UINavigationController,
                             flowHandler: MenuCoordinatorHandler) -> MenuCoordinator {
        return MenuCoordinator(navigationController: navigationController, flowHandler: flowHandler)
    }
}
