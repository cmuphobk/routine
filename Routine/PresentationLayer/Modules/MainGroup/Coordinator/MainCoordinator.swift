import UIKit

protocol MainCoordinatorDelegate: class {
    
}

class MainCoordinator: Coordinatorable, NavigationConfiguration {

    // MARK: - Coordinatorable
    var navigationController: UINavigationController
    var childCoordinators: [Coordinatorable] = []

    // MARK: - NavigationConfiguration
    var parentNavigationConfiguration: NavigationConfiguration?
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
    
}
