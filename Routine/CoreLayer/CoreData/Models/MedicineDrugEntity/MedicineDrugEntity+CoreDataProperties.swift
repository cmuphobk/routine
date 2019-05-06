import Foundation
import CoreData

extension MedicineDrugEntity {

    @nonobjc class func fetchRequest() -> NSFetchRequest<MedicineDrugEntity> {
        return NSFetchRequest<MedicineDrugEntity>(entityName: "MedicineDrugEntity")
    }

    @NSManaged var name: String?
    @NSManaged var comment: String?
    @NSManaged var startDate: Int64
    @NSManaged var endDate: Int64
    @NSManaged var type: Int16
    @NSManaged var unit: Int16
    @NSManaged var course: MedicineCourseEntity?
    @NSManaged var times: NSSet?
    
    @NSManaged var endingCourseValue: Int64
    @NSManaged var endingCourseType: Int64
    
    @NSManaged var periodCourseValue: Int64
    @NSManaged var periodCourseType: Int64

}

// MARK: Generated accessors for times
extension MedicineDrugEntity {

    @objc(addTimesObject:)
    @NSManaged func addToTimes(_ value: MedicineCourseTimeEntity)

    @objc(removeTimesObject:)
    @NSManaged func removeFromTimes(_ value: MedicineCourseTimeEntity)

    @objc(addTimes:)
    @NSManaged func addToTimes(_ values: NSSet)

    @objc(removeTimes:)
    @NSManaged func removeFromTimes(_ values: NSSet)

}
