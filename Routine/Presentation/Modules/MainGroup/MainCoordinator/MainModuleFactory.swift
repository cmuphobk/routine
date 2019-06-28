import UIKit

class MainModuleFactory {
    func makeMainViewController(with coordinator: MainCoordinator) ->
        (input: MainModuleInput?, view: UIViewController) {
        return MainAssembly.buildMainScreenModuleWith(coordinator: coordinator)
    }
}
