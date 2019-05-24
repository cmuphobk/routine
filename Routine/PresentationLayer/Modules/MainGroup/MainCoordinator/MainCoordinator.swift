import UIKit

protocol MainCoordinatorDelegate: class {
    
}

class MainCoordinator: Coordinatorable, ScreenEventManager {
    
    // MARK: - Coordinatorable
    var navigationController: UINavigationController
    var parentCoordinator: Coordinatorable?
    
    var childCoordinators: [Coordinatorable] = []
    var childViewControllers: [UIViewController] = []

    // MARK: - ScreenEventManager
    var parentScreenEventManager: ScreenEventManager?
    var taskHideError: DispatchWorkItem!
    
    // MARK: - MainCoordinator
    var factory = MainModuleFactory()
    weak var delegate: MainCoordinatorDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.factory.makeMainViewController(with: self) { (viewController, _) in
            if let viewController = viewController {
                self.push(viewController: viewController, animated: true)
            }
        }
    }
    
    func childDidFinish(_ child: Coordinatorable) {
        
    }
}

extension MainCoordinator: MainRouterOutput {
    
}
