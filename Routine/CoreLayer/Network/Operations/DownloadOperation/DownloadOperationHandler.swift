
import Foundation
import Alamofire

final class DownloadOperationHandler: RequestOperationHandler {
    
    typealias RequestObjectType = DownloadRequestObject
    var requestObject: DownloadRequestObject
    
    var response: Data?
    var error: Error?
    var statusCode: Int?
    
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
    
    init(withRequestObject requestObject: DownloadRequestObject) {
        self.requestObject = requestObject
    }
    
    func deserializeResponseObject(_ object: Any) {
        
        guard let downloadResponseObject = object as? DownloadResponse<Data> else { return }
        self.error = downloadResponseObject.error
        self.response = downloadResponseObject.result.value
        self.statusCode = downloadResponseObject.response?.statusCode

    }
    
}
