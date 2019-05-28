import Foundation
import Alamofire

final class MultipartOperationHandler<T: Decodable>: RequestOperationHandler, DecodeResponseContainerInterface {

    typealias RequestObjectType = MultipartRequestObject
    typealias DecodeResponseType = T

    var requestObject: MultipartRequestObject

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
        return AppDelegate.serviceProvider.makeStringService().localizeId(R.string.localizable.error_network.key)
    }

    init(withRequestObject requestObject: MultipartRequestObject) {
        self.requestObject = requestObject
    }

    func deserializeResponseObject(_ object: Any) {

        guard let networkResponseObject = object as? DataResponse<Any> else { return }

        self.error = networkResponseObject.error
        self.response = networkResponseObject.data
        self.statusCode = networkResponseObject.response?.statusCode

        if let responseData = self.response {
            let decoder = JSONDecoder()
            var entry: T?
            do {
                entry = try decoder.decode(T.self, from: responseData)
            } catch {
                print(error)
            }
            self.decodeResponse = entry
        }

    }

}
