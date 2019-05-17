import UIKit

protocol MenuCoordinating {

}

enum MenuCoordinatorActionType {
}

class MenuCoordinatorHandler: CoordinatorHandler<MenuCoordinatorActionType> { }

class MenuCoordinator: Coordinatorable<MenuCoordinatorHandler> {

    var factory: MenuCoordinatorFactory

    override init(navigationController: UINavigationController,
                  flowHandler: MenuCoordinatorHandler?) {
        self.factory = MenuCoordinatorFactory()
        super.init(navigationController: navigationController,
                   flowHandler: flowHandler)
    }

    override func start() {
        self.factory.makeMenuViewController(with: self) { (viewController, _) in
            if let viewController = viewController {
                self.push(viewController: viewController, animated: true)
            }
        }

    }

}

extension MenuCoordinator: MenuCoordinating {
    
}
