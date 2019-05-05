
import Foundation
import CoreData

@objc(MedicineCourseEntity)
class MedicineCourseEntity: NSManagedObject, ConfigurableEntityInterface {
    
    private let drugRepository = CoreDataRepository<MedicineDrugEntity, MedicineDrug>()
    
    func configureWithModel(_ model: IdentifierModelInterface) -> Bool {
        
        guard let modelUnwrap = model as? MedicineCourse else {
            return false
        }
        
        self.name = modelUnwrap.name
        self.startDate = Int64(modelUnwrap.startDate)
        self.endDate = Int64(modelUnwrap.endDate)
        
        if modelUnwrap.drugs?.count == nil || modelUnwrap.drugs?.count == 0 {
            return true
        }
        
        modelUnwrap.drugs?.forEach({ [unowned self] (drug) in
            if let drugEntity = self.drugRepository.createOrUpdateEntityWithModel(model: drug) {
                self.addToDrugs(drugEntity)
            }
        })
        return true
    }
    
}
