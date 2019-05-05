
import Foundation

enum AuthServiceAssembly {
    
    static func build(storageService: StorageServiceInterface) -> AuthServiceInterface {
        
        let authService = AuthService()
        
        authService.authRequestFactory = AuthRequestFactoryAssembly.build()
        authService.authStorage = AuthStorageAssembly.build(storageService: storageService)
        authService.operationQueue = OperationQueue()
        
        return authService
        
    }
    
}
