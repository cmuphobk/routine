import UIKit

protocol MedicineCourseCoordinating {
    
}

enum MedicineCourseCoordinatorActionType {
    
}

class MedicineCourseCoordinatorHandler: CoordinatorHandler<MedicineCourseCoordinatorActionType> { }

class MedicineCourseCoordinator: Coordinatorable<MedicineCourseCoordinatorHandler>, NavigationConfiguration {
    
    var factory: MedicineCourseCoordinatorFactory
    
    var parentNavigationConfiguration: NavigationConfiguration?
    weak var idiomCheckerDelegate: IdiomCheckerDelegate?
    weak var messageConfigurationDelegate: MessageConfigurationDelegate?
    var taskHideError: DispatchWorkItem!
    
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
