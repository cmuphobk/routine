import Foundation
import CoreData

extension MedicineCourseTimeEntity {

    @nonobjc class func fetchRequest() -> NSFetchRequest<MedicineCourseTimeEntity> {
        return NSFetchRequest<MedicineCourseTimeEntity>(entityName: "MedicineCourseTimeEntity")
    }

    @NSManaged var dose: Double
    @NSManaged var usageTime: Int64
    @NSManaged var course: MedicineDrugEntity?

}
