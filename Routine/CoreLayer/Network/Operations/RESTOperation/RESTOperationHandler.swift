
import Foundation
import Alamofire

final class RESTOperationHandler<T: Decodable>: RequestOperationHandler, DecodeResponseContainerInterface {
    
    typealias RequestObjectType = RESTRequestObject
    typealias DecodeResponseType = T
    
    var requestObject: RESTRequestObject
    
    var response: Data?
    var error: Error?
    var statusCode: Int?
    
    var decodeResponse: T?
    
    var status: RESTStatus {
        
        guard let statusCode = self.statusCode else {
            return .unknown
        }
        
        switch statusCode {
        case 100..<200:
            return .informational
        case 200..<300:
            return .success
        case 300..<400:
            return .redirection
        case 400..<500:
            return .clientError
        case 500..<600:
            return .serverError
        default:
            return .unknown
        }
        
    }
    
    var responseError: String? {
        guard self.status == .unknown else {
            return nil
        }
        return AppDelegate.serviceProvider.makeStringService().localizeById("error_network")
    }
    
    init(withRequestObject requestObject: RESTRequestObject) {
        self.requestObject = requestObject
    }
    
    func deserializeResponseObject(_ object: Any) {
        
        guard let networkResponseObject = object as? DataResponse<Any> else {
            return
        }
        
        self.error = networkResponseObject.error
        self.response = networkResponseObject.data
        self.statusCode = networkResponseObject.response?.statusCode
        
        if let responseData = self.response {
            if let str = String(data: responseData, encoding: String.Encoding.utf8) {
                print(str)
            }

            let decoder = JSONDecoder()
            var entry: T?
            do {
                entry = try decoder.decode(T.self, from: responseData.isEmpty ? "{}".data(using: String.Encoding.utf8)! : responseData)
            } catch {
                print(error)
            }
            self.decodeResponse = entry
        }

    }
    
}
