import Foundation
import CoreData
import MagicalRecord

// FIXME: - абстрагироваться от базы и фреймфорка
final class MagicalRecordService: MagicalRecordServiceInterface {

    private let cultureCoreDataModelName = "RoutineModel"

    func setupCoreDataStack() {
        MagicalRecord.setupCoreDataStack(withStoreNamed: self.cultureCoreDataModelName)
    }

    func cleanUp() {
        MagicalRecord.cleanUp()
    }

}
