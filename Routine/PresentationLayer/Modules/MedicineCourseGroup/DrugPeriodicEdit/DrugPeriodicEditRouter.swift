import Foundation
import UIKit

final class DrugPeriodicEditRouter: DrugPeriodicEditModuleRouter {
    weak var viewController: UIViewController?
    var moduleService: ModuleServiceInterface!
    
    func closeModule() {
//        self.moduleService.navigation?.popModule()
    }
}
