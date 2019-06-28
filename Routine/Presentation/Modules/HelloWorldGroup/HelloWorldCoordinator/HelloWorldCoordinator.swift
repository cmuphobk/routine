import UIKit

protocol HelloWorldCoordinatorDelegate: class {

}

class HelloWorldCoordinator: Coordinatorable {

    // MARK: - Coordinatorable
    var navigationController: UINavigationController
    var parentCoordinator: Coordinatorable?

    var childCoordinators: [Coordinatorable] = []
    var childViewControllers: [UIViewController] = []

    // MARK: - MainCoordinator
    var factory = HelloWorldModuleFactory()
    weak var delegate: HelloWorldCoordinatorDelegate?

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let module = self.factory.makeHelloWorldViewController(with: self)
        self.push(viewController: module.view, animated: true)
    }

    func childDidFinish(_ child: Coordinatorable) {

    }
}

extension HelloWorldCoordinator: HelloWorldRouterOutput {

}
