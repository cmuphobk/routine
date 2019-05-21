import Foundation
import UIKit

final class DrugTimesEditRouter: DrugTimesEditModuleRouter {
    weak var viewController: UIViewController!
    var coordinator: MedicineCourseCoordinator!
    
    func closeModule() {
//        self.moduleService.navigation?.popModule()
    }
}
