import UIKit

final class ModuleService: ModuleServiceInterface {

    func obtainAvailableModulesAndActionsIds() -> [ModuleDescription] {
        return [
            mainDescription,
            helloWorldDescription
        ]
    }

    func obtainModuleIdBeforeLaunch () -> String {
        return mainDescription.name
    }

}
