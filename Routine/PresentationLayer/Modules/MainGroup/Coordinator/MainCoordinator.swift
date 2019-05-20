import UIKit

protocol MainCoordinating {
    
}

enum MainCoordinatorActionType {
    
}

class MainCoordinatorHandler: CoordinatorHandler<MainCoordinatorActionType> { }

class MainCoordinator: Coordinatorable<MainCoordinatorHandler>, NavigationConfiguration {
        
    var factory: MainCoordinatorFactory
    
    var parentNavigationConfiguration: NavigationConfiguration?
    weak var idiomCheckerDelegate: IdiomCheckerDelegate?
    weak var messageConfigurationDelegate: MessageConfigurationDelegate?
    var taskHideError: DispatchWorkItem!
    
    override init(navigationController: UINavigationController,
                  flowHandler: MainCoordinatorHandler?) {
        
        self.factory = MainCoordinatorFactory()
        super.init(navigationController: navigationController,
                   flowHandler: flowHandler)
    }
    
    override func start() {
        self.factory.makeMainViewController(with: self) { (viewController, _) in
            if let viewController = viewController {
                self.push(viewController: viewController, animated: true)
            }
        }
    }
    
}

extension MainCoordinator: MainCoordinating {
    
}
