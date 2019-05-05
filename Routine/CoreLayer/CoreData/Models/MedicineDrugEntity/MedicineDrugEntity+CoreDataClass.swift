
import Foundation
import CoreData

@objc(MedicineDrugEntity)
class MedicineDrugEntity: NSManagedObject, ConfigurableEntityInterface {
    
    let timeRepository = CoreDataRepository<MedicineCourseTimeEntity, MedicineCourseTime>()
    
    func configureWithModel(_ model: IdentifierModelInterface) -> Bool {
        
        guard let modelUnwrap = model as? MedicineDrug else {
            return false
        }
        
        self.name = modelUnwrap.name
        self.comment = modelUnwrap.comment
        
        self.startDate = Int64(modelUnwrap.startDate)
        self.endDate = Int64(modelUnwrap.endDate ?? 0)
        self.type = Int16(modelUnwrap.type.value)
        self.unit = Int16(modelUnwrap.unit.value)
        
        self.endingCourseValue = Int64(modelUnwrap.endingCourseValue)
        self.endingCourseType = Int64(modelUnwrap.endingCourseType.rawValue)
        
        self.periodCourseValue = Int64(modelUnwrap.periodCourseValue)
        self.periodCourseType = Int64(modelUnwrap.periodCourseType.rawValue)
        
        if let objectId = modelUnwrap.courseObjectId, let url = URL(string: objectId), let managedObjectID = self.managedObjectContext?.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url) {
            
            let parentEntity = self.managedObjectContext?.object(with: managedObjectID)
            if let parentEntity = parentEntity as? MedicineCourseEntity {
                self.course = parentEntity
            }
            
        }
        
        if modelUnwrap.times.count == 0 {
            return true
        }
        
        modelUnwrap.times.forEach({ [unowned self] (time) in
            if let timeEntity = self.timeRepository.createOrUpdateEntityWithModel(model: time) {
                self.addToTimes(timeEntity)
            }
        })
        
        return true
        
    }
}
