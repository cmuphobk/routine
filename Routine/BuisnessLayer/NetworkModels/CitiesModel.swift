import Foundation

struct CitiesRequestModel: Codable {
    var order: String
}

struct CityResponseModel: Codable {
    var identifier: Int
    var title: String
    var idRegion: Int
    var titleRegion: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id", title, idRegion, titleRegion
    }
}

struct CitiesResponseModel: Codable {
    var cities: [CityResponseModel]?
    var errors: [BaseResponeErrorModel]?
}
