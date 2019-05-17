import Foundation
import UIKit

final class DrugTimesEditRouter: DrugTimesEditModuleRouter {
    weak var viewController: UIViewController?
    var moduleService: ModuleServiceInterface!
    
    func closeModule() {
//        self.moduleService.navigation?.popModule()
    }
}
