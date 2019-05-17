import UIKit

protocol MedicineCourseCoordinating {
    
}

class MedicineCourseCoordinatorHandler: CoordinatorHandler<MedicineCourseCoordinator.ActionType> { }

class MedicineCourseCoordinator: Coordinatorable<MedicineCourseCoordinatorHandler> {
    
    enum ActionType: Int {
    }
    
    var factory: MedicineCourseCoordinatorFactory
    
    override init(navigationController: UINavigationController,
                  flowHandler: MedicineCourseCoordinatorHandler?) {
        
        self.factory = MedicineCourseCoordinatorFactory()
        super.init(navigationController: navigationController,
                   flowHandler: flowHandler)
    }
    
    override func start() {
        self.factory.makeMedicineCourseViewController(with: self) { (viewController, _) in
            if let viewController = viewController {
                self.push(viewController: viewController, animated: true)
            }
        }
    }
    
}

extension MedicineCourseCoordinator: MedicineCourseCoordinating {
    
}
