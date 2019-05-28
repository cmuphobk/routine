import UIKit

enum MenuModuleAssembly {

    static func buildMenuModule(with coordinator: ApplicationCoordinator, completion: ( MenuModuleInput?) -> Void) {

        // Creating module components
        guard let moduleViewController = R.storyboard.menuViewController.menuViewController() else {
            completion(nil)
            return
        }
        let presenter = MenuPresenter()
        let router = MenuRouter()

        // Inject properties
        moduleViewController.output = presenter
        presenter.view = moduleViewController
        presenter.router = router
        presenter.localizeService = AppDelegate.serviceProvider.makeStringService()
        presenter.menuTableViewFactory = MenuTableViewFactoryAssembly.build()
        router.routerOutput = coordinator

        completion(presenter)
    }

}
