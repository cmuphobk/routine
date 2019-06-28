import Foundation
import Alamofire

final class RESTOperation<T: Decodable> : AsyncOperation, OperationHandlerContainerInterface {

    typealias OperationHandler = RESTOperationHandler<T>

    private var privateAlamofireManager: SessionManager!
    private var alamofireManager: SessionManager {
        if self.privateAlamofireManager == nil {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 20.0
            configuration.timeoutIntervalForResource = 40.0
            self.privateAlamofireManager = Alamofire.SessionManager(configuration: configuration)
        }
        return self.privateAlamofireManager
    }

    var handler: RESTOperationHandler<T>!

    init(withHandler handler: RESTOperationHandler<T>) {
        self.handler = handler

        super.init()
    }

    override func main() {
        if self.isCancelled {
            return
        }

        guard let requestObject = self.handler?.requestObject, let handler = self.handler else {
            self.state = .finished
            return
        }

        let url = requestObject.url

        let parameters = requestObject.parameters

        let request = self.alamofireManager.request(url,
                                                    method: requestObject.method,
                                                    parameters: parameters,
                                                    encoding: requestObject.encoding ?? URLEncoding.default,
                                                    headers: requestObject.headers) as DataRequest

        request.responseJSON { [unowned self] (responseJSON) in
            if self.isCancelled {
                return
            }

            handler.deserializeResponseObject(responseJSON)

            self.state = .finished
        }

    }
}
