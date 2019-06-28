import UIKit

class HelloWorldModuleFactory {
    func makeHelloWorldViewController(with coordinator: HelloWorldCoordinator) ->
        (input: HelloWorldModuleInput?, view: UIViewController) {
        return HelloWorldAssembly.buildHelloWorldScreenModuleWith(coordinator: coordinator)
    }
}
