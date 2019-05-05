import Foundation
import MagicalRecord
import UIKit

class MedicineDrugService: MedicineDrugServiceInterface {

    //protocol dependecies
    typealias Model = MedicineDrug
    
    //service dependecies
    var repository: CoreDataRepository<MedicineDrugEntity, MedicineDrug>!
    var localNotificationService: LocalNotificationServiceInterface!
    
    //service implementation
    func obtainAll() -> [MedicineDrug] {
        var drugs: [MedicineDrug] = []
        
        drugs = self.repository.obtainEnititesWithFilterObject(nil).map({ (entity) -> MedicineDrug in
            return MedicineDrug(entity: entity)
        })
        
        return drugs
    }
    
    func obtainAllForCourse(medicineCourse: MedicineCourse) -> [MedicineDrug] {
        var drugs: [MedicineDrug] = []
        guard let parentId = medicineCourse.objectId else { return [] }
            
        drugs = self.repository.obtainEnititesWithFilterObject(NSPredicate(format: "course == %@", parentId)).map({ (entity) -> MedicineDrug in
            return MedicineDrug(entity: entity)
        })
        
        return drugs
    }

    func createOrUpdate(_ model: MedicineDrug, complition: @escaping (MedicineDrug?) -> Void) {
        guard let entity = self.repository.createOrUpdateEntityWithModel(model: model) else { return }
        
        self.repository.context.mr_saveToPersistentStore { [unowned entity] (_, _) in
            let model = MedicineDrug(entity: entity)
            DispatchQueue.main.async(execute: {
                complition( model )
            })
            
        }
    }
    
    func delete(_ model: MedicineDrug) -> Bool {
        let result = self.repository.deleteEntityWithModel(model: model)
        self.repository.context.mr_saveToPersistentStoreAndWait()
        return result
    }
}
