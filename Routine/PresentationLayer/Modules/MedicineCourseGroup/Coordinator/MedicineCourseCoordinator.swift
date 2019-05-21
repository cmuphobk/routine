import UIKit

protocol MedicineCourseCoordinatorDelegate: class {
    
}

class MedicineCourseCoordinator: Coordinatorable, NavigationConfiguration {
    
    // MARK: - Coordinatorable
    var navigationController: UINavigationController
    var childCoordinators: [Coordinatorable] = []

    // MARK: - NavigationConfiguration
    var parentNavigationConfiguration: NavigationConfiguration?
    var taskHideError: DispatchWorkItem!
    
    // MARK: - MedicineCourseCoordinator
    var factory = MedicineCourseModuleFactory()
    weak var delegate: MedicineCourseCoordinatorDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.factory.makeMedicineCourseViewController(with: self) { (viewController, _) in
            if let viewController = viewController {
                self.push(viewController: viewController, animated: true)
            }
        }
    }
    
}
