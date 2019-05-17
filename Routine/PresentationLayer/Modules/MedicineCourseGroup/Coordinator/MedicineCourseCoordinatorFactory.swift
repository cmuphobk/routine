import UIKit

class MedicineCourseCoordinatorFactory {
    
    func makeMedicineCourseViewController(with coordinator: MedicineCourseCoordinator,
                                          completion: (UIViewController?, MedicineCourseModuleInput?) -> Void) {
        
        completion(nil, nil)
    }
    
}
