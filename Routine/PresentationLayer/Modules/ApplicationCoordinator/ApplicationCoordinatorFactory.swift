import UIKit

class ApplicationCoordinatorFactory {
    
    func makeMainCoordinator(navigationController: UINavigationController,
                             delegate: MainCoordinatorDelegate,
                             parentScreenEventManager: ScreenEventManager?) -> MainCoordinator {
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.delegate = delegate
        coordinator.parentScreenEventManager = parentScreenEventManager
        return coordinator
    }
    
}