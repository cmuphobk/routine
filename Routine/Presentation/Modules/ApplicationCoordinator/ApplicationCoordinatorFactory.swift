import UIKit

class ApplicationCoordinatorFactory {

    func makeMainCoordinator(navigationController: UINavigationController,
                             delegate: MainCoordinatorDelegate) -> MainCoordinator {
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.delegate = delegate
        coordinator.parentCoordinator = delegate as? Coordinatorable
        return coordinator
    }

    func makeHelloWorldCoordinator(navigationController: UINavigationController,
                                   delegate: HelloWorldCoordinatorDelegate) -> HelloWorldCoordinator {
        let coordinator = HelloWorldCoordinator(navigationController: navigationController)
        coordinator.delegate = delegate
        coordinator.parentCoordinator = delegate as? Coordinatorable
        return coordinator
    }

}
