import Foundation

protocol DataArrayContainer {

    associatedtype Item

    var dataArray: [Item]? { get set }
}

struct DefaultModel: Codable {

    var response: String

    enum CodingKeys: String, CodingKey {
        case response
    }

}

class ArrayModel <T: Codable>: Codable, DataArrayContainer {

    typealias Item = T

    var dataArray: [Item]?

    init() {}

    required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dataArray = try container.decode([T].self, forKey: .dataArray)

    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.dataArray, forKey: CodingKeys.dataArray)

    }

    enum CodingKeys: String, CodingKey {
        case dataArray = "result"
    }
}

protocol Entity {
    var identifier: String { get set }
}

struct IdModel: Codable, Entity {
    var identifier: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
    }
}
