
import Foundation

struct BaseResponeErrorModel: Codable {
    var code: RESTCode?
    var message: String?
    var data: [String: String?]?
}

struct EmptyResponseModel: Codable {
    var errors: [BaseResponeErrorModel]?
}

struct TokenHeaderModel: Codable {
    var authorization: String?
    
    enum CodingKeys: String, CodingKey {
        case authorization = "Authorization"
    }
}

struct TokenResponseModel: Codable {
    var token: String?
    var errors: [BaseResponeErrorModel]?
}
