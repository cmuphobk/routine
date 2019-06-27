import UIKit

final class MainRouter: BaseRouter {
    weak var viewController: UIViewController!
    weak var routerOutput: RouterOutput!
}

extension MainRouter: MainRouterInput {

}
