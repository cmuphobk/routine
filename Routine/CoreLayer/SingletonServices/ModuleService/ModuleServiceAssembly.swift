import Foundation

enum ModuleServiceAssembly {
    
    static func build() -> ModuleServiceInterface {
        
        let moduleService = ModuleService.shared
        
        moduleService.moduleFactory = ModuleFactoryAssembly.build()
        
        return moduleService
        
    }
    
}
