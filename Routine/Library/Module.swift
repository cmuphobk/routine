import UIKit

protocol Module {
    var name: String { get set }
    var alias: String { get set }
    var viewController: UIViewController! { get }
}

typealias ModuleDescription = (name: String, alias: String)

protocol ModuleInput: Module {
    func configureModule()
}

extension ModuleInput {
    func configureModule() {

    }
}

protocol ModuleOutput: class {

}

protocol ViewInput: class {
    func setupInitialState()
}

extension ViewInput {
    func setupInitialState() {

    }
}

protocol ViewOutput: Module {
    func didTriggerViewReadyEvent()
}

extension ViewOutput {
    func didTriggerViewReadyEvent() {

    }
}

protocol RouterInput: class {

}

protocol RouterOutput: ScreenEventManager {

}

protocol BasePresenter {
    associatedtype ViewType//: ViewInput
    associatedtype RouterType//: RouterInput
    var view: ViewType! { get set }
    var router: RouterType! { get set }
}

protocol BaseView {
    associatedtype OutputType//: ViewOutput
    var output: OutputType! { get set }
}

protocol BaseRouter {
    associatedtype OutputType//: RouterOutput
    var routerOutput: OutputType! { get set }
    var viewController: UIViewController! { get set }
}
