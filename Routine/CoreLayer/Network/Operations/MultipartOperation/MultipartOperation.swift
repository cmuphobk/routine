import Foundation
import Alamofire

class MultipartOperation<T: Decodable>: AsyncOperation, OperationHandlerContainerInterface {
    
    typealias OperationHandler = MultipartOperationHandler<T>
    
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
    
    var handler: MultipartOperationHandler<T>!
    
    init(withHandler handler: MultipartOperationHandler<T>) {
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
        
        guard let parameters = requestObject.parameters else {
            self.state = .finished
            return
        }
        
        self.alamofireManager.upload(multipartFormData: parameters, usingThreshold: UInt64.init(), to: url, method: requestObject.method, headers: requestObject.headers) { [unowned self] (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    DispatchQueue.main.async {
                        print(progress.fractionCompleted)
                    }
                })

                upload.validate()
                upload.responseJSON { [unowned self, unowned handler] response in
                    
                    if self.isCancelled {
                        return
                    }
                    handler.deserializeResponseObject(response)
                    self.state = .finished
                    
                }
                
            case .failure:
                
                if self.isCancelled {
                    return
                }
                
                let error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "File Uploading Failed. Please try again."]) as Error
                let result = Result<AnyObject>.failure(error)
                let response = DataResponse(request: nil, response: nil, data: nil, result: result)
                handler.deserializeResponseObject(response)
                self.state = .finished
                
            }
            
        }
        
    }
}
