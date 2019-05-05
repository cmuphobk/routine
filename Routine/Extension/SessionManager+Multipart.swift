import Foundation
import Alamofire

extension SessionManager {
    
    fileprivate struct CustomProperties {
        static var queueExt = "queueExt"
    }
    
    fileprivate var queueExt: DispatchQueue {
        get {
            if let queueExt = objc_getAssociatedObject(self, &CustomProperties.queueExt) as? DispatchQueue {
                return queueExt
            } else {
                self.queueExt = DispatchQueue(label: "org.alamofire.session-manager." + UUID().uuidString)
                return self.queueExt
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, &CustomProperties.queueExt, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Copy from Alamofire SessionManager
    
    func upload(
        multipartFormData: MultipartFormData,
        usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
        to url: URLConvertible,
        method: HTTPMethod = .post,
        headers: HTTPHeaders? = nil,
        encodingCompletion: ((MultipartFormDataEncodingResult) -> Void)?) {
        do {
            let urlRequest = try URLRequest(url: url, method: method, headers: headers)
            
            return self.upload(
                multipartFormData: multipartFormData,
                usingThreshold: encodingMemoryThreshold,
                with: urlRequest,
                encodingCompletion: encodingCompletion
            )
        } catch {
            DispatchQueue.main.async { encodingCompletion?(.failure(error)) }
        }
    }
    
    func upload(
        multipartFormData: MultipartFormData,
        usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
        with urlRequest: URLRequestConvertible,
        encodingCompletion: ((MultipartFormDataEncodingResult) -> Void)?) {
        DispatchQueue.global(qos: .utility).async {
            let formData = multipartFormData
            
            var tempFileURL: URL?
            
            do {
                var urlRequestWithContentType = try urlRequest.asURLRequest()
                urlRequestWithContentType.setValue(formData.contentType, forHTTPHeaderField: "Content-Type")
                
                let isBackgroundSession = self.session.configuration.identifier != nil
                
                if formData.contentLength < encodingMemoryThreshold && !isBackgroundSession {
                    let data = try formData.encode()
                    
                    let encodingResult = MultipartFormDataEncodingResult.success(
                        request: self.upload(data, with: urlRequestWithContentType),
                        streamingFromDisk: false,
                        streamFileURL: nil
                    )
                    
                    DispatchQueue.main.async { encodingCompletion?(encodingResult) }
                } else {
                    let fileManager = FileManager.default
                    let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
                    let directoryURL = tempDirectoryURL.appendingPathComponent("org.alamofire.manager/multipart.form.data")
                    let fileName = UUID().uuidString
                    let fileURL = directoryURL.appendingPathComponent(fileName)
                    
                    tempFileURL = fileURL
                    
                    var directoryError: Error?
                    
                    // Create directory inside serial queue to ensure two threads don't do this in parallel
                    self.queueExt.sync {
                        do {
                            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                        } catch {
                            directoryError = error
                        }
                    }
                    
                    if let directoryError = directoryError { throw directoryError }
                    
                    try formData.writeEncodedData(to: fileURL)
                    
                    let upload = self.upload(fileURL, with: urlRequestWithContentType)
                    
                    // Cleanup the temp file once the upload is complete
                    upload.delegate.queue.addOperation {
                        do {
                            try FileManager.default.removeItem(at: fileURL)
                        } catch {
                            // No-op
                        }
                    }
                    
                    DispatchQueue.main.async {
                        let encodingResult = MultipartFormDataEncodingResult.success(
                            request: upload,
                            streamingFromDisk: true,
                            streamFileURL: fileURL
                        )
                        
                        encodingCompletion?(encodingResult)
                    }
                }
            } catch {
                // Cleanup the temp file in the event that the multipart form data encoding failed
                if let tempFileURL = tempFileURL {
                    do {
                        try FileManager.default.removeItem(at: tempFileURL)
                    } catch {
                        // No-op
                    }
                }
                
                DispatchQueue.main.async { encodingCompletion?(.failure(error)) }
            }
        }
    }
    
}
