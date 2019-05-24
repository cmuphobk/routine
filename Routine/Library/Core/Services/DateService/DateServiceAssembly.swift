import Foundation

enum DateServiceAssembly {
    
    static func build(languageService: LanguageServiceInterface) -> DateServiceInterface {
        
        let dateServiceInterface = DateService.shared
        dateServiceInterface.languageService = languageService
        
        return dateServiceInterface
        
    }
    
}
