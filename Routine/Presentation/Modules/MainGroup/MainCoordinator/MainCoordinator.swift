import UIKit

protocol MainCoordinatorDelegate: class {

}

class MainCoordinator: Coordinatorable {

    // MARK: - Coordinatorable
    var navigationController: UINavigationController
    var parentCoordinator: Coordinatorable?

    var childCoordinators: [Coordinatorable] = []
    var childViewControllers: [UIViewController] = []

    // MARK: - MainCoordinator
    var factory = MainModuleFactory()
    weak var delegate: MainCoordinatorDelegate?

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.factory.makeMainViewController(with: self) { (moduleInput) in
            if let viewController = moduleInput?.viewController {
                self.push(viewController: viewController, animated: true)
            }
        }
    }

    func childDidFinish(_ child: Coordinatorable) {

    }
}

extension MainCoordinator: MainRouterOutput {

}
