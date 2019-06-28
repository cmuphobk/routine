import UIKit

final class HelloWorldRouter: BaseRouter {
    weak var viewController: UIViewController!
    weak var routerOutput: HelloWorldRouterOutput!
}

extension HelloWorldRouter: HelloWorldRouterInput {

}
