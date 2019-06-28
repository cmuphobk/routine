import UIKit

enum MainAssembly {

    static func buildMainScreenModuleWith(coordinator: MainCoordinator) ->
    (input: MainModuleInput?, view: UIViewController) {
        // Creating module components
        let viewController = MainViewController()
        let presenter = MainPresenter()
        let router = MainRouter()

        // Inject properties
        viewController.output = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.localizeService = AppDelegate.serviceProvider.makeStringService()
        router.viewController = viewController
        router.routerOutput = coordinator

        viewController.color = ColorProvider.default
        viewController.font = FontProvider.default
        viewController.image = ImageProvider.default

        return (input: presenter, view: viewController)
    }

}
