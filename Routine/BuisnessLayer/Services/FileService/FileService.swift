
import Foundation
import Alamofire

final class FileService: FileServiceInterface {
    
    private let downloadQueue: OperationQueue!
    
    init() {
        self.downloadQueue = OperationQueue()
    }
    
    func obtainImage(_ imageUrl: String, success: @escaping (URL) -> Void, failure: @escaping (String?) -> Void) {
        
        let fileManager = FileManager.default
        var fileUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName: String = String( imageUrl.split(separator: "/").last ?? "" )
        fileUrl.appendPathComponent("images_" + fileName)
        
        if fileManager.fileExists(atPath: fileUrl.path) {
            OperationQueue.main.addOperation({
                success(fileUrl)
            })
        } else {
            let parameters: [String: String] = [:]
            
            let requestObject = DownloadRequestObject(method: .get, encoding: URLEncoding.default, parameters: parameters, headers: nil, url: imageUrl, fileUrl: fileUrl)
            let networkOperationHandler = DownloadOperationHandler(withRequestObject: requestObject)
            let downloadOperation = DownloadOperation(withHandler: networkOperationHandler)
            
            downloadOperation.completionBlock = { [unowned downloadOperation] in
                if downloadOperation.isCancelled {
                    return
                }
                guard let handler = downloadOperation.handler, handler.response != nil else {
                    OperationQueue.main.addOperation {
                        failure("Unhandled error!")
                    }
                    return
                }
                if handler.error == nil {
                    OperationQueue.main.addOperation {
                        success(fileUrl)
                    } 
                } else {
                    OperationQueue.main.addOperation {
                        failure(handler.responseError)
                    }
                    
                }
            }
            
            self.downloadQueue.addOperations([downloadOperation], waitUntilFinished: false)
        }
        
    }
    
    func obtainDocument(_ documentUrl: String, success: @escaping (URL) -> Void, failure: @escaping (String?) -> Void) {
        
        let fileManager = FileManager.default
        var fileUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileName: String = String(documentUrl.split(separator: "/").last ?? "")
        fileUrl.appendPathComponent("documents_" + String(fileName))
        
        if fileManager.fileExists(atPath: fileUrl.path) {
            OperationQueue.main.addOperation({
                success(fileUrl)
            })
        } else {
            let parameters: [String: String] = [:]
            let requestObject = DownloadRequestObject(method: .get, encoding: URLEncoding.default, parameters: parameters, headers: nil, url: documentUrl, fileUrl: fileUrl)
            let networkOperationHandler = DownloadOperationHandler(withRequestObject: requestObject)
            let downloadOperation = DownloadOperation(withHandler: networkOperationHandler)
            
            downloadOperation.completionBlock = { [unowned downloadOperation] in
                if downloadOperation.isCancelled {
                    return
                }
                guard let handler = downloadOperation.handler, handler.response != nil else {
                    OperationQueue.main.addOperation({
                        failure("Unhandled error!")
                    })
                    return
                }
                if handler.error == nil {
                    OperationQueue.main.addOperation({
                        success(fileUrl)
                    })
                } else {
                    OperationQueue.main.addOperation({
                        failure(handler.responseError)
                    })
                    
                }
            }
            
            self.downloadQueue.addOperations([downloadOperation], waitUntilFinished: false)
        }
        
    }
    
}
