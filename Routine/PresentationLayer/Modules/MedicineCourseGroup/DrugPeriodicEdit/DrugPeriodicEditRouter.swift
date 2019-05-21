import Foundation
import UIKit

final class DrugPeriodicEditRouter: DrugPeriodicEditModuleRouter {
    weak var viewController: UIViewController!
    var coordinator: MedicineCourseCoordinator!
    
    func closeModule() {
//        self.moduleService.navigation?.popModule()
    }
}
