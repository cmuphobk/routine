import Foundation
import CoreData

@objc(MedicineCourseTimeEntity)
class MedicineCourseTimeEntity: NSManagedObject, ConfigurableEntityInterface {
    
    func configureWithModel(_ model: IdentifierModelInterface) -> Bool {
        
        guard let modelUnwrap = model as? MedicineCourseTime else {
            return false
        }
        
        self.dose = modelUnwrap.dose
        self.usageTime = Int64(modelUnwrap.usageTime.rawValue())
        
        return true
        
    }
    
}
