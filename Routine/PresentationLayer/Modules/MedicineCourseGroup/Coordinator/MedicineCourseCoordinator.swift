import UIKit

protocol MedicineCourseCoordinatorDelegate: class {
    
}

class MedicineCourseCoordinator: Coordinatorable, ScreenEventManager {
    
    // MARK: - Coordinatorable
    var navigationController: UINavigationController
    var childCoordinators: [Coordinatorable] = []

    // MARK: - ScreenEventManager
    var parentScreenEventManager: ScreenEventManager?
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

extension MedicineCourseCoordinator: MedicineCourseRouterOutput {
    
}

extension MedicineCourseCoordinator: DrugsListRouterOutput {
    
}

extension MedicineCourseCoordinator: DrugEditRouterOutput {
    
}

extension MedicineCourseCoordinator: DrugTimesEditRouterOutput {
    
}

extension MedicineCourseCoordinator: DrugDetailsRouterOutput {
    
}

extension MedicineCourseCoordinator: DrugPeriodicEditRouterOutput {
    
}
