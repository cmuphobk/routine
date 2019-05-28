import Foundation
import CoreData
import MagicalRecord

final class MagicalRecordService: MagicalRecordServiceInterface {

    private let cultureCoreDataModelName = "RoutineModel"

    static var shared = MagicalRecordService()

    private init () {}

    func setupCoreDataStack() {
        MagicalRecord.setupCoreDataStack(withStoreNamed: self.cultureCoreDataModelName)
    }

    func cleanUp() {
        MagicalRecord.cleanUp()
    }

}
