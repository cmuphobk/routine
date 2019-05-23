import Foundation
import UIKit

final class DrugTimesEditRouter: BaseRouter {
    weak var viewController: UIViewController!
    var routerOutput: DrugTimesEditRouterOutput!
}

extension DrugTimesEditRouter: DrugTimesEditRouterInput {
    func closeModule() {
//        self.moduleService.navigation?.popModule()
    }
}
