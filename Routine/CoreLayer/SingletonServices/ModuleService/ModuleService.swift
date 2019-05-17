import UIKit

protocol Module {
    var name: String { get set }
    var alias: String { get set }
    var viewController: UIViewController? { get }
}

typealias ModuleDescription = (name: String, alias: String)

final class ModuleService: ModuleServiceInterface {
    
    static let shared = ModuleService()
    
    var moduleFactory: ModuleFactoryInterface!
    
    private init() {}
    
    func obtainAvailableModulesAndActionsIds() -> [ModuleDescription] {
        return [
            (name: kMainModuleId, alias: kMainModuleAlias),
            (name: kMedicineCourseModuleId, alias: kMedicineCourseModuleAlias)
        ]
    }
    
    func obtainModuleIdBeforeLaunch () -> String {
        
        return kMainModuleId
    }

}
