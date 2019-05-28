import Foundation
import MagicalRecord

final class CoreDataRepository<EntityGeneric: NSManagedObject & ConfigurableEntityInterface, ModelGeneric: IdentifierModelInterface>: Repository {

    var context: NSManagedObjectContext

    init() {
        self.context = NSManagedObjectContext.mr_default()
    }

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    typealias Entity = EntityGeneric
    typealias Model = ModelGeneric

    func obtainEntityById(objectId: String?) -> Entity? {

        guard let objectIdUnwrap = objectId else { return nil }

        guard let url = URL(string: objectIdUnwrap), let managedObjectID = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url) else {
            return nil
        }

        let predicate = NSPredicate(format: "self == %@", managedObjectID)
        guard let entityFound = EntityGeneric.mr_findFirst(with: predicate, in: self.context) else {
            return nil
        }

        return entityFound

    }

    func obtainEnititesWithFilterObject(_ filterObject: Any?) -> [EntityGeneric] {

        let predicate = filterObject as? NSPredicate

        guard let entities = EntityGeneric.mr_findAll(with: predicate, in: self.context) as? [EntityGeneric] else { return [] }

        return entities

    }

    func createOrUpdateEntityWithModel(model: ModelGeneric) -> EntityGeneric? {

        var entity: EntityGeneric?

        if let entityFound = self.obtainEntityById(objectId: model.objectId) {
            entity = entityFound
        } else {
            guard let entityCreated = EntityGeneric.mr_createEntity(in: self.context) else {
                return nil
            }
            entity = entityCreated
        }

        if entity?.configureWithModel(model) != true {
            return nil
        }

        return entity
    }

    func deleteEntityWithModel(model: ModelGeneric) -> Bool {

        guard let url = URL(string: model.objectId ?? ""), let managedObjectID = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url) else {
            return false
        }

        let predicate = NSPredicate(format: "self == %@", managedObjectID)
        if EntityGeneric.mr_deleteAll(matching: predicate, in: self.context) == false {
            return false
        }

        return true

    }

}
