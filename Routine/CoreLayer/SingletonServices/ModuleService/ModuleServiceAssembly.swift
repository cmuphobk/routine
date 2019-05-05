import Foundation

enum ModuleServiceAssembly {
    
    static func build(_ authService: AuthServiceInterface) -> ModuleServiceInterface {
        
        let moduleService = ModuleService.shared
        
        moduleService.authService = authService
        moduleService.moduleFactory = ModuleFactoryAssembly.build()
        
        return moduleService
        
    }
    
}
