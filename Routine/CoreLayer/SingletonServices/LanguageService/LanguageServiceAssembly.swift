import Foundation

enum LanguageServiceAssembly {
    
    static func build(storageService: StorageServiceInterface) -> LanguageServiceInterface {
        
        let languageService = LanguageService.shared
        languageService.storageService = storageService
        return languageService
        
    }
    
}
