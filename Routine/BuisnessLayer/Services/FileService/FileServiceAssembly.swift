
import Foundation

enum FileServiceAssembly {
    
    static func build() -> FileServiceInterface {
        
        let fileService = FileService()
        
        return fileService
        
    }
    
}
