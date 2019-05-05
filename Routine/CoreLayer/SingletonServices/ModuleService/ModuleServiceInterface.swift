import Foundation

protocol ModuleServiceInterface: class {
    
    var moduleFactory: ModuleFactoryInterface! { get }
    
    var navigation: NavigatorInterface? { get set }
    
    func obtainAvailableModulesAndActionsIds() -> [ModuleDescription]
    
    func obtainModuleIdBeforeLaunch () -> String
    
}
