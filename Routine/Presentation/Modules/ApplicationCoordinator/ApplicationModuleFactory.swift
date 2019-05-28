import UIKit

class ApplicationModuleFactory {

    func makeMenuViewController(with coordinator: ApplicationCoordinator,
                                completion: (MenuModuleInput?) -> Void) {

        MenuModuleAssembly.buildMenuModule(with: coordinator,
                                           completion: completion)

    }

}
