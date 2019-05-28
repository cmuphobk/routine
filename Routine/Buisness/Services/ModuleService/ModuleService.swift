import UIKit

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
