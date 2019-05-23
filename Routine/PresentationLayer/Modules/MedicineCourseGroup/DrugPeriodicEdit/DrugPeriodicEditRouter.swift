import Foundation
import UIKit

final class DrugPeriodicEditRouter: BaseRouter {
    var routerOutput: DrugPeriodicEditRouterOutput!
    var viewController: UIViewController!
}

extension DrugPeriodicEditRouter: DrugTimesEditRouterInput {
    func closeModule() {
//        self.moduleService.navigation?.popModule()
    }
}
