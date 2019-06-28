import Foundation

enum ModuleServiceAssembly {
    static func build() -> ModuleServiceInterface {
        let moduleService = ModuleService()
        return moduleService
    }
}
