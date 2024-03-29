import UIKit

protocol Module {
    var name: String { get set }
    var alias: String { get set }
    var viewController: UIViewController? { get }
}

typealias ModuleDescription = (name: String, alias: String)

final class ModuleService: ModuleServiceInterface {
    
    
    private var backgroundViewController: BackgroundViewController?
    var navigation: NavigatorInterface? {
        get {
            return self.backgroundViewController
        }
        set {
            guard let backgroundViewController = newValue as? BackgroundViewController else { return }
            self.backgroundViewController = backgroundViewController
        }
    }
    
    static let shared = ModuleService()
    
    var authService: AuthServiceInterface!
    
    var moduleFactory: ModuleFactoryInterface!
    
    
    
    private init() {}
    
    func obtainAvailableModulesAndActionsIds() -> [ModuleDescription] {
        return [
            (name: kMainModuleId, alias: kMainModuleAlias),
            (name: kMedicineCourseModuleId, alias: kMedicineCourseModuleAlias),
            (name: kAuthModuleId, alias: kAuthModuleAlias)
        ]
    }
    
    func obtainModuleIdBeforeLaunch () -> String {
        
//        return self.authService.isAuth ? kMainModuleId : kAuthModuleId
        return kMainModuleId
    }

}
