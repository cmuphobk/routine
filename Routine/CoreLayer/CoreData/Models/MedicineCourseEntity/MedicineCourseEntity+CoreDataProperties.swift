import Foundation
import CoreData

extension MedicineCourseEntity {

    @nonobjc class func fetchRequest() -> NSFetchRequest<MedicineCourseEntity> {
        return NSFetchRequest<MedicineCourseEntity>(entityName: "MedicineCourseEntity")
    }

    @NSManaged var name: String?
    @NSManaged var drugs: NSSet?
    @NSManaged var startDate: Int64
    @NSManaged var endDate: Int64

}

// MARK: Generated accessors for drugs
extension MedicineCourseEntity {

    @objc(addDrugsObject:)
    @NSManaged func addToDrugs(_ value: MedicineDrugEntity)

    @objc(removeDrugsObject:)
    @NSManaged func removeFromDrugs(_ value: MedicineDrugEntity)

    @objc(addDrugs:)
    @NSManaged func addToDrugs(_ values: NSSet)

    @objc(removeDrugs:)
    @NSManaged func removeFromDrugs(_ values: NSSet)

}
