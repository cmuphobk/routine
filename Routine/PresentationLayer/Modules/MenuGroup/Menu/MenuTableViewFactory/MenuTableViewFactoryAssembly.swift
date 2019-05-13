import Foundation

enum MenuTableViewFactoryAssembly {
    
    static func build() -> MenuTableViewFactoryInterface {
        
        let menuFactory = MenuTableViewFactory()
        
        return menuFactory
        
    }
    
}
