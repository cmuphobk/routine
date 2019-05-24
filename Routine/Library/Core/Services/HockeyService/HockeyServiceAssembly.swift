import Foundation

enum HockeyServiceAssembly {
    
    static func build() -> HockeyServiceInterface {
        
        let hockeyService = HockeyService.shared
        
        return hockeyService
        
    }
    
}
