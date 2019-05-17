import UIKit

protocol ApplicationCoordinating {
    
}

class ApplicationCoordinatorHandler: CoordinatorHandler<ApplicationCoordinator.ActionType> { }

class ApplicationCoordinator: Coordinatorable<ApplicationCoordinatorHandler> {
    
    enum ActionType: Int {
        
    }

    var coordinatorFactory: CoordinatorFactory

    var menuCoordinator: MenuCoordinator!
    
    let menuFlowHandler = MenuCoordinatorHandler { (actionType) in
        print("AppCoordinator output: \(actionType) with hash: \(actionType.hashValue)")
    }

    override init(navigationController: UINavigationController, flowHandler: ApplicationCoordinatorHandler?) {
        self.coordinatorFactory = CoordinatorFactory()
        
        self.menuCoordinator = MenuCoordinator(navigationController: navigationController, flowHandler: menuFlowHandler)
        
        super.init(navigationController: navigationController,
                   flowHandler: flowHandler)
    }


    override func start() {
        self.menuCoordinator.start()
    }
    
}

extension ApplicationCoordinator: ApplicationCoordinating {
    
}
