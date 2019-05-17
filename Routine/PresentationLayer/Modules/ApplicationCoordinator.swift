import UIKit

protocol ApplicationCoordinating {
    
}

enum ApplicationCoordinatorActionType {
    
}

class ApplicationCoordinatorHandler: CoordinatorHandler<ApplicationCoordinatorActionType> { }

class ApplicationCoordinator: Coordinatorable<ApplicationCoordinatorHandler> {

    var coordinatorFactory: CoordinatorFactory

    var menuCoordinator: MenuCoordinator!
    
    let menuFlowHandler = MenuCoordinatorHandler { (actionType) in
        print("AppCoordinator output: \(actionType)")
    }

    override init(navigationController: UINavigationController,
                  flowHandler: ApplicationCoordinatorHandler?) {
        self.coordinatorFactory = CoordinatorFactory()
        
        self.menuCoordinator = self.coordinatorFactory.makeMenuCoordinator(navigationController: navigationController,
                                                                           flowHandler: self.menuFlowHandler)
        
        super.init(navigationController: navigationController,
                   flowHandler: flowHandler)
    }


    override func start() {
        self.menuCoordinator.start()
    }
    
}

extension ApplicationCoordinator: ApplicationCoordinating {
    
}
