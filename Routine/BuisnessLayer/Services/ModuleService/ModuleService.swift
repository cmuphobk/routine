import UIKit

protocol Module {
    var name: String { get set }
    var alias: String { get set }
    var viewController: UIViewController! { get }
}

typealias ModuleDescription = (name: String, alias: String)

final class ModuleService: ModuleServiceInterface {
    
    static let shared = ModuleService()
        
    private init() {}
    
    func obtainAvailableModulesAndActionsIds() -> [ModuleDescription] {
        return [
            ModuleDescription(name: R.string.localizable.main_name.key,
                              alias: R.string.localizable.main_alias.key)
        ]
    }
    
    func obtainModuleIdBeforeLaunch () -> String {
        return R.string.localizable.main_name.key
    }

}
