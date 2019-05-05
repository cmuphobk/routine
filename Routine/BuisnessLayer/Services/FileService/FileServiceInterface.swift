
import Foundation

protocol FileServiceInterface {
    
    func obtainImage(_ imageUrl: String, success: @escaping (URL) -> Void, failure: @escaping (String?) -> Void)
    
    func obtainDocument(_ documentUrl: String, success: @escaping (URL) -> Void, failure: @escaping (String?) -> Void)
}
