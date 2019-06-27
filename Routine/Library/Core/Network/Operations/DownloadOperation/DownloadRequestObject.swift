import Foundation
import Alamofire

class DownloadRequestObject: RequestObject<[String: Any]> {

    let fileUrl: URL

    init(method: HTTPMethod,
         encoding: ParameterEncoding?,
         parameters: [String: Any]?,
         headers: HTTPHeaders?,
         url: String,
         fileUrl: URL) {
        self.fileUrl = fileUrl

        super.init(method: method, encoding: encoding, parameters: parameters, headers: headers, url: url)
    }

}
