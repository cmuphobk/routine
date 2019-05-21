import UIKit

class MedicineCourseModuleFactory {
    
    func makeMedicineCourseViewController(with coordinator: MedicineCourseCoordinator,
                                          completion: (UIViewController?, MedicineCourseModuleInput?) -> Void) {
        
        MedicineCourseAssembly.buildMedicineCourseScreenModule(with: coordinator, completion)
    }
    
}
