import Foundation

struct MedicineCourseTime: IdentifierModelInterface {
    
    var objectId: String?
    var dose: Double
    var usageTime: Time
    
    init(dose: Double, usageTime: Time) {
        self.dose = dose
        self.usageTime = usageTime
    }
    
    init(entity: MedicineCourseTimeEntity) {
        self.objectId = entity.objectID.uriRepresentation().absoluteString
        self.dose = entity.dose
        self.usageTime = Time()
        self.usageTime.setTime(milisec: Int(entity.usageTime))
    }
    
}
