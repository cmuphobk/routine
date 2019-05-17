import UIKit

protocol MainCoordinating {
    
}

class MainCoordinatorHandler: CoordinatorHandler<MainCoordinator.ActionType> { }

class MainCoordinator: Coordinatorable<MainCoordinatorHandler> {
    
    enum ActionType: Int {
    }
    
    var factory: MainCoordinatorFactory
    
    override init(navigationController: UINavigationController,
                  flowHandler: MainCoordinatorHandler?) {
        
        self.factory = MainCoordinatorFactory()
        super.init(navigationController: navigationController,
                   flowHandler: flowHandler)
    }
    
    override func start() {
        self.factory.makeMainViewController(with: self) { (viewController, _) in
            if let viewController = viewController {
                self.push(viewController: viewController, animated: true)
            }
        }
    }
    
}

extension MainCoordinator: MainCoordinating {
    
}
