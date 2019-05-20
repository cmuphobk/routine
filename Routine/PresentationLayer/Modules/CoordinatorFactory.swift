import UIKit

extension CoordinatorFactory {
    
    func makeMenuCoordinator(navigationController: UINavigationController,
                             flowHandler: MenuCoordinatorHandler) -> MenuCoordinator {
        return MenuCoordinator(navigationController: navigationController, flowHandler: flowHandler)
    }
    
    func makeMainCoordinator(navigationController: UINavigationController,
                             flowHandler: MainCoordinatorHandler) -> MainCoordinator {
        return MainCoordinator(navigationController: navigationController, flowHandler: flowHandler)
    }
    
    func makeMedicineCourseCoordinator(navigationController: UINavigationController,
                                       flowHandler: MedicineCourseCoordinatorHandler) -> MedicineCourseCoordinator {
        return MedicineCourseCoordinator(navigationController: navigationController, flowHandler: flowHandler)
    }
}
