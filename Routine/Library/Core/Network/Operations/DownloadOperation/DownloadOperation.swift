import Foundation
import Alamofire

class DownloadOperation: AsyncOperation, OperationHandlerContainerInterface {
    
    typealias OperationHandler = DownloadOperationHandler
    
    var handler: DownloadOperationHandler!

    init(withHandler handler: DownloadOperationHandler) {
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
        
        let parameters = requestObject.parameters
        
        let fileUrl = requestObject.fileUrl

        let destination: DownloadRequest.DownloadFileDestination = { _, _  in
            return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        let request = Alamofire.download(requestObject.url, method: requestObject.method, parameters: parameters, encoding: requestObject.encoding ?? URLEncoding.default, headers: requestObject.headers, to: destination)

        request.responseData { [unowned self] (data) in
            if self.isCancelled {
                return
            }

            handler.deserializeResponseObject(data)

            self.state = .finished
        }
        
    }
}
