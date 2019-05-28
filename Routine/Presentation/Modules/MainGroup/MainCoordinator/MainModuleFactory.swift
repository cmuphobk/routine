import UIKit

class MainModuleFactory {

    func makeMainViewController(with coordinator: MainCoordinator,
                                completion: (MainModuleInput?) -> Void) {

        MainAssembly.buildMainScreenModuleWith(coordinator: coordinator,
                                               completion: completion)
    }

}
