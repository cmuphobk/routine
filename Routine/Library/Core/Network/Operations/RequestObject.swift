import Foundation
import Alamofire

class RequestObject<ParametersType> {

    let method: HTTPMethod
    let encoding: ParameterEncoding?
    let parameters: ParametersType?
    let headers: HTTPHeaders?

    let url: String

    init(method: HTTPMethod,
         encoding: ParameterEncoding?,
         parameters: ParametersType?,
         headers: HTTPHeaders?,
         url: String) {
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
        self.url = url
    }

}
