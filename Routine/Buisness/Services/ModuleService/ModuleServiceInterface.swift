import Foundation

protocol ModuleServiceInterface: class {

    func obtainAvailableModulesAndActionsIds() -> [ModuleDescription]

    func obtainModuleIdBeforeLaunch () -> String

}
