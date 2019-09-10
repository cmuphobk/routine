import UIKit

protocol Nameable {
    var name: String { get }
}

struct ModuleDescription: Nameable, CustomStringConvertible {
    var name: String
    var description: String
}

protocol Module {
    var description: ModuleDescription { get }
    var viewController: UIViewController! { get }
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

    var color: ColorTheme! { get set }
    var font: FontTheme! { get set }
    var image: ImageTheme! { get set }
}

protocol BaseRouter {
    associatedtype OutputType//: RouterOutput
    var routerOutput: OutputType! { get set }
    var viewController: UIViewController! { get set }
}
