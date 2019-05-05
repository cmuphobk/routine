
import Foundation

enum MedicineCourseServiceAssembly {
    
    static func build() -> MedicineCourseServiceInterface {
        
        let medicineCourseService = MedicineCourseService()
        
        medicineCourseService.repository = CoreDataRepository<MedicineCourseEntity, MedicineCourse>()
        medicineCourseService.localNotificationService = AppDelegate.serviceProvider.makeLocalNotificationService()
        
        return medicineCourseService
        
    }
    
}
