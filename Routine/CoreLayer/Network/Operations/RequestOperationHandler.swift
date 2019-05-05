
import Foundation
import Alamofire

protocol RequestOperationHandler {
    
    associatedtype RequestObjectType
    
    var requestObject: RequestObjectType { get set }
    
    var response: Data? { get set }
    var error: Error? { get set }
    var statusCode: Int? { get }
    
    var responseError: String? { get }
    
    func deserializeResponseObject(_ object: Any)
    
}
