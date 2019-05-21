import UIKit

class ApplicationCoordinatorFactory {
    
    func makeMainCoordinator(navigationController: UINavigationController,
                             delegate: MainCoordinatorDelegate,
                             parentNavigationConfiguration: NavigationConfiguration?) -> MainCoordinator {
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.delegate = delegate
        coordinator.parentNavigationConfiguration = parentNavigationConfiguration
        return coordinator
    }
    
    func makeMedicineCourseCoordinator(navigationController: UINavigationController,
                                       delegate: MedicineCourseCoordinatorDelegate,
                                       parentNavigationConfiguration: NavigationConfiguration?) -> MedicineCourseCoordinator {
        let coordinator = MedicineCourseCoordinator(navigationController: navigationController)
        coordinator.delegate = delegate
        coordinator.parentNavigationConfiguration = parentNavigationConfiguration
        return coordinator
    }
}
