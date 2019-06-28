import UIKit

final class MainRouter: BaseRouter {
    weak var viewController: UIViewController!
    weak var routerOutput: MainRouterOutput!
}

extension MainRouter: MainRouterInput {
    func didTriggerHelloWorld() {
        self.routerOutput.didTriggerHelloWorld()
    }
}
