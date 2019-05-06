import Foundation

enum AuthRequestFactoryAssembly {
    
    static func build() -> AuthRequestFactoryInterface {
        
        let authFactory = AuthRequestFactory()
        
        return authFactory
        
    }
    
}
