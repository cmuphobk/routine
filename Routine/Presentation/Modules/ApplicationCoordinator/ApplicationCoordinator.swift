import UIKit

protocol ApplicationCoordinatorDelegate: class {

}

class ApplicationCoordinator: NSObject, Coordinatorable {
    // MARK: - Coordinatorable
    var navigationController: UINavigationController
    var parentCoordinator: Coordinatorable?

    var childCoordinators: [Coordinatorable] = []
    var childViewControllers: [UIViewController] = []

    // MARK: - ApplicationCoordinator
    var rootView: UIView!
    var windowService: WindowServiceInterface!
    var moduleService: ModuleServiceInterface!

    var coordinatorFactory = ApplicationCoordinatorFactory()
    weak var delegate: ApplicationCoordinatorDelegate?

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.delegate = self

        let mainCoordinator = self.coordinatorFactory.makeMainCoordinator(
            navigationController: self.navigationController,
            delegate: self)
        self.childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }

    func childDidFinish(_ child: Coordinatorable) {

    }
}

extension ApplicationCoordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from)
            else {
                return
            }

        if navigationController.viewControllers.contains(fromViewController) { return }

        self.viewControllerDidBackForward(fromViewController)
    }

}

extension ApplicationCoordinator: MainCoordinatorDelegate {
    func didTriggerHelloWorld() {
        let helloWorldCoordinator = self.coordinatorFactory.makeHelloWorldCoordinator(
            navigationController: self.navigationController,
            delegate: self)
        self.childCoordinators.append(helloWorldCoordinator)
        helloWorldCoordinator.start()
    }
}

extension ApplicationCoordinator: HelloWorldCoordinatorDelegate {

}
