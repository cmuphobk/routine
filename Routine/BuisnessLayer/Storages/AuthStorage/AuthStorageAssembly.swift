import Foundation

enum AuthStorageAssembly {
    
    static func build(storageService: StorageServiceInterface) -> AuthStorageInterface {
        
        let authStorage = AuthStorage()
        authStorage.storageService = storageService
        
        return authStorage
        
    }
    
}
