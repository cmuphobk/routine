import UIKit

protocol ApplicationCoordinating {
    
}

enum ApplicationCoordinatorActionType {
    
}

class ApplicationCoordinatorHandler: CoordinatorHandler<ApplicationCoordinatorActionType> { }

class ApplicationCoordinator: Coordinatorable<ApplicationCoordinatorHandler>, NavigationConfiguration {
    
    var windowService: WindowService!
    var menuCoordinator: MenuCoordinator!
    let menuFlowHandler = MenuCoordinatorHandler { (actionType) in
        print("AppCoordinator output: \(actionType)")
    }
    let standartOffsetLabel = StandartOffsetLabel()
    let imageView = UIImageView()
    
    var parentNavigationConfiguration: NavigationConfiguration?
    weak var idiomCheckerDelegate: IdiomCheckerDelegate?
    weak var menuConfigurationDelegate: MenuConfigurationDelegate?
    weak var messageConfigurationDelegate: MessageConfigurationDelegate?
    var taskHideError: DispatchWorkItem!

    override init(navigationController: UINavigationController,
                  flowHandler: ApplicationCoordinatorHandler?) {
        
        super.init(navigationController: navigationController,
                   flowHandler: flowHandler)
        
        self.menuCoordinator = self.coordinatorFactory.makeMenuCoordinator(navigationController: navigationController,
                                                                           flowHandler: self.menuFlowHandler)
    }


    override func start() {
        self.menuCoordinator.start()
    }
    
}

extension ApplicationCoordinator: ApplicationCoordinating {
    
}

extension ApplicationCoordinator: IdiomCheckerDelegate {
    var userInterfaceIdiom: UIUserInterfaceIdiom {
        return self.windowService.userInterfaceIdiom
    }
}

extension ApplicationCoordinator: MenuConfigurationDelegate {
    func obtainMenuModuleViewController() -> UIViewController {
        return self.menuCoordinator.menuViewController
    }
    
    func obtainMenuViewWidth() -> CGFloat {
        return self.menuCoordinator.menuViewController.view.frame.width
    }
}

extension ApplicationCoordinator: MessageConfigurationDelegate {
    func obtainMessageWidth() -> CGFloat {
        return self.windowService.screenWidth
    }
    
    func obtainTextOffset() -> CGFloat {
        return 15.0
    }
    
    func obtainIconHeight() -> CGFloat {
        return 25.0
    }
    
    func obtainLeftOffset() -> CGFloat {
        return 0.0
    }
    
    func obtainErrorLabel() -> StandartOffsetLabel {
        return self.standartOffsetLabel
    }
    
    func obtainErrorImageView() -> UIImageView {
        return self.imageView
    }
}
