import UIKit

protocol ApplicationCoordinating {
    
}

enum ApplicationCoordinatorActionType {

}

class ApplicationCoordinatorHandler: CoordinatorHandler<ApplicationCoordinatorActionType> { }

class ApplicationCoordinator: Coordinatorable<ApplicationCoordinatorHandler>, NavigationConfiguration {
    
    var windowService: WindowServiceInterface!
    var moduleService: ModuleServiceInterface!
    let standartOffsetLabel = StandartOffsetLabel()
    let imageView = UIImageView()
    
    var menuCoordinator: MenuCoordinator!
    lazy var menuFlowHandler = MenuCoordinatorHandler { (actionType) in
        switch actionType {
        case .main:
            self.mainCoordinator.start()
        case .medicineCourse:
            self.medicineCourseCoordinator.start()
        }
    }
    
    var mainCoordinator: MainCoordinator!
    let mainFlowHandler = MainCoordinatorHandler { (actionType) in
        print("MainCoordinator output: \(actionType)")
    }
    
    var medicineCourseCoordinator: MedicineCourseCoordinator!
    let medicineCourseFlowHandler = MedicineCourseCoordinatorHandler { (actionType) in
        print("MedicineCourseCoordinator output: \(actionType)")
    }
    
    var parentNavigationConfiguration: NavigationConfiguration?
    weak var idiomCheckerDelegate: IdiomCheckerDelegate?
    weak var messageConfigurationDelegate: MessageConfigurationDelegate?
    var taskHideError: DispatchWorkItem!

    override init(navigationController: UINavigationController,
                  flowHandler: ApplicationCoordinatorHandler?) {
        
        super.init(navigationController: navigationController,
                   flowHandler: flowHandler)
        
        self.menuCoordinator = self.coordinatorFactory.makeMenuCoordinator(navigationController: navigationController,
                                                                           flowHandler: self.menuFlowHandler)
        
        self.mainCoordinator = self.coordinatorFactory.makeMainCoordinator(navigationController: navigationController,
                                                                           flowHandler: self.mainFlowHandler)
        
        self.medicineCourseCoordinator = self.coordinatorFactory.makeMedicineCourseCoordinator(navigationController: navigationController,
                                                                           flowHandler: self.medicineCourseFlowHandler)
    }


    override func start() {
        self.menuCoordinator.moduleService = self.moduleService
        self.menuCoordinator.start()
        self.mainCoordinator.start()
    }
    
}

extension ApplicationCoordinator: ApplicationCoordinating {
    
}

extension ApplicationCoordinator: IdiomCheckerDelegate {
    var userInterfaceIdiom: UIUserInterfaceIdiom {
        return self.windowService.userInterfaceIdiom
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
