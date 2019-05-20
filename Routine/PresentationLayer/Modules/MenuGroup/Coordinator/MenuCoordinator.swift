import UIKit

protocol MenuCoordinating {

}

enum MenuCoordinatorActionType {
}

class MenuCoordinatorHandler: CoordinatorHandler<MenuCoordinatorActionType> { }

class MenuCoordinator: Coordinatorable<MenuCoordinatorHandler>, NavigationConfiguration {
    
    var factory: MenuCoordinatorFactory
    var menuViewController: UIViewController!
    
    var parentNavigationConfiguration: NavigationConfiguration?
    weak var idiomCheckerDelegate: IdiomCheckerDelegate?
    weak var menuConfigurationDelegate: MenuConfigurationDelegate?
    weak var messageConfigurationDelegate: MessageConfigurationDelegate?
    var taskHideError: DispatchWorkItem!

    override init(navigationController: UINavigationController,
                  flowHandler: MenuCoordinatorHandler?) {
        self.factory = MenuCoordinatorFactory()
        super.init(navigationController: navigationController,
                   flowHandler: flowHandler)
    }

    override func start() {
        self.factory.makeMenuViewController(with: self) { (viewController, _) in
            if let viewController = viewController {
                self.menuViewController = viewController
            }
        }

    }

}
