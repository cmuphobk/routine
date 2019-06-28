import UIKit

protocol MainCoordinatorDelegate: class {
    func didTriggerHelloWorld()
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
        let module = self.factory.makeMainViewController(with: self)
        self.push(viewController: module.view, animated: true)
    }

    func childDidFinish(_ child: Coordinatorable) {

    }
}

extension MainCoordinator: MainRouterOutput {
    func didTriggerHelloWorld() {
        self.delegate?.didTriggerHelloWorld()
    }
}
