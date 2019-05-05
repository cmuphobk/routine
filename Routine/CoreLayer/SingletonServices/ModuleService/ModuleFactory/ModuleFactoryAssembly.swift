import Foundation

enum ModuleFactoryAssembly {
    
    static func build() -> ModuleFactoryInterface {
        
        let moduleFactory = ModuleFactory()
        
        return moduleFactory
        
    }
    
}
