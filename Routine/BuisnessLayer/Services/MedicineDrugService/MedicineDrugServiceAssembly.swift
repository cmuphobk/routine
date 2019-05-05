import Foundation

enum MedicineDrugServiceAssembly {
    
    static func build() -> MedicineDrugServiceInterface {
        
        let medicineDrugService = MedicineDrugService()
        
        medicineDrugService.repository = CoreDataRepository<MedicineDrugEntity, MedicineDrug>()
        medicineDrugService.localNotificationService = AppDelegate.serviceProvider.makeLocalNotificationService()
        
        return medicineDrugService
        
    }
    
}
