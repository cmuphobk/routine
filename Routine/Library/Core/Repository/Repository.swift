import Foundation
import CoreData

protocol Repository {

    associatedtype Entity: ConfigurableEntityInterface
    associatedtype Model: IdentifierModelInterface

    func obtainEntityById(objectId: String?) -> Entity?

    func obtainEnititesWithFilterObject(_ fiterObject: Any?) -> [Entity]

    func createOrUpdateEntityWithModel(model: Model) -> Entity?

    func deleteEntityWithModel(model: Model) -> Bool

}
