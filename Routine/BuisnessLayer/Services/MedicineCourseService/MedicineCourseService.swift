import Foundation
import MagicalRecord
import UIKit

final class MedicineCourseService: MedicineCourseServiceInterface {
    
    //protocol dependecies
    typealias Model = MedicineCourse
    
    //service dependecies
    var repository: CoreDataRepository<MedicineCourseEntity, MedicineCourse>!
    var localNotificationService: LocalNotificationServiceInterface!
    
    //service implementation
    func obtainAll() -> [MedicineCourse] {
        var medCourses: [MedicineCourse] = []
        
        medCourses = self.repository.obtainEnititesWithFilterObject(nil).map({ (entity) -> MedicineCourse in
            return MedicineCourse(entity: entity)
        })
        
        return medCourses
    }
    
    func obtainCurrentCourses() -> [MedicineCourse] {
        var medCourses: [MedicineCourse] = []
        
        medCourses = self.repository.obtainEnititesWithFilterObject(NSPredicate(format: "endDate >= \(Int(Date().timeIntervalSince1970 * 1000.0)) || endDate == 0 || endDate == nil") ).map({ (entity) -> MedicineCourse in
            return MedicineCourse(entity: entity)
        })
        
        return medCourses
    }
    
    func obtainArchiveCourses() -> [MedicineCourse] {
        var medCourses: [MedicineCourse] = []
        
        medCourses = self.repository.obtainEnititesWithFilterObject(NSPredicate(format: "endDate < \(Int(Date().timeIntervalSince1970 * 1000.0)) && endDate != 0 && endDate != nil") ).map({ (entity) -> MedicineCourse in
            return MedicineCourse(entity: entity)
        })
        
        return medCourses
    }
    
    func createOrUpdate(_ model: MedicineCourse, complition: @escaping (MedicineCourse?) -> Void) {
        guard let entity = self.repository.createOrUpdateEntityWithModel(model: model) else { return }
        
        self.repository.context.mr_saveToPersistentStore(completion: { [unowned self] (success, _) in
            let model = MedicineCourse(entity: entity)
            DispatchQueue.main.async(execute: {
                self.configureNotificatons()
                complition(success ? model : nil)
            })
            
        })
        
        
    }
    
    func delete(_ model: MedicineCourse) -> Bool {
        let result = self.repository.deleteEntityWithModel(model: model)
        self.removeNotifications(model: model)
        self.repository.context.mr_saveToPersistentStoreAndWait()
        return result
    }
}

// MARK: - Private
extension MedicineCourseService {
    
    private func configureNotificatons() {
        
        let courses = self.obtainCurrentCourses()
        self.localNotificationService.createNotifications(courses)
        
    }
    
    private func removeNotifications(model: MedicineCourse) {
        
        self.localNotificationService.removeAllNotifications()
        
    }
    
}
