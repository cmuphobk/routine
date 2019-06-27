import UIKit

class ApplicationCoordinatorFactory {

    func makeMainCoordinator(navigationController: UINavigationController,
                             delegate: MainCoordinatorDelegate) -> MainCoordinator {
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.delegate = delegate
        return coordinator
    }

}
