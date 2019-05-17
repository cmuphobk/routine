import Foundation

protocol ModuleServiceInterface: class {
    
    var moduleFactory: ModuleFactoryInterface! { get }
        
    func obtainAvailableModulesAndActionsIds() -> [ModuleDescription]
    
    func obtainModuleIdBeforeLaunch () -> String
    
}
