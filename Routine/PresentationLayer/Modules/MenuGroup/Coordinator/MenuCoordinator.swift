import UIKit

protocol MenuCoordinating {
    func openModuleById(_ identifier: String)
    func openMenu()
    func hideMenu()
}

enum MenuCoordinatorActionType: String {
    case main
    case medicineCourse
}

class MenuCoordinatorHandler: CoordinatorHandler<MenuCoordinatorActionType> { }

class MenuCoordinator: Coordinatorable<MenuCoordinatorHandler>, NavigationConfiguration {
    
    var factory: MenuCoordinatorFactory
    var menuViewController: UIViewController!
    let menuViewWidth: CGFloat = 300.0
    var moduleService: ModuleServiceInterface!
    
    var parentNavigationConfiguration: NavigationConfiguration?
    weak var idiomCheckerDelegate: IdiomCheckerDelegate?
    weak var messageConfigurationDelegate: MessageConfigurationDelegate?
    var taskHideError: DispatchWorkItem!

    override init(navigationController: UINavigationController,
                  flowHandler: MenuCoordinatorHandler?) {
        self.factory = MenuCoordinatorFactory()
        super.init(navigationController: navigationController,
                   flowHandler: flowHandler)
    }

    override func start() {
        self.factory.makeMenuViewController(with: self) { (viewController, moduleInput) in
            moduleInput?.configureModule(menuItems: self.moduleService.obtainAvailableModulesAndActionsIds())
            if let viewController = viewController {
                self.menuViewController = viewController
                self.menuViewController.view.frame = CGRect(x: -self.menuViewWidth, y: 0, width: self.menuViewWidth, height: self.view.frame.height)
                self.navigationController.addChild(viewController)
                self.view.addSubview(viewController.view)
            }
        }

    }

}

extension MenuCoordinator: MenuCoordinating {
    
    func openModuleById(_ identifier: String) {
        let actionType: MenuCoordinatorActionType!
        switch identifier {
        case kMainModuleId:
            actionType = .main
        case kMedicineCourseModuleId:
            actionType = .medicineCourse
        default:
            return
        }
        
       self.flowHandler?.closure(actionType)
        
    }
    
}


extension MenuCoordinator: MenuConfiguration {
    
    func triggerMenu() {
        if self.menuViewController.view.frame.origin.x < 0 {
            self.openMenu()
        } else {
            self.hideMenu()
        }
    }
    
    func openMenu() {
        self.menuViewController.view.frame = CGRect(x: -self.menuViewWidth, y: 0, width: self.menuViewWidth, height: self.view.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.menuViewController.view.frame = CGRect(x: 0, y: 0, width: self.menuViewWidth, height: self.view.frame.height)
            self.navigationController.view.frame = CGRect(x: self.menuViewWidth, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            // FIXME: - wtf
            self.menuViewController.viewWillAppear(false)
            self.view.setNeedsLayout()
        }, completion: nil)
    }
    
    func hideMenu() {
        self.menuViewController.view.frame = CGRect(x: 0, y: 0, width: self.menuViewWidth, height: self.view.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.menuViewController.view.frame = CGRect(x: -self.menuViewWidth, y: 0, width: self.menuViewWidth, height: self.view.frame.height)
            self.navigationController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.setNeedsLayout()
        }, completion: nil)
    }
    
}
