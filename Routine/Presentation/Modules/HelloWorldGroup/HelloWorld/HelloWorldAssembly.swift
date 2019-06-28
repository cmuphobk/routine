import UIKit

enum HelloWorldAssembly {

    static func buildHelloWorldScreenModuleWith(coordinator: HelloWorldCoordinator) ->
        (input: HelloWorldModuleInput?, view: UIViewController) {
        // Creating module components
        let viewController = HelloWorldViewController()
        let presenter = HelloWorldPresenter()
        let router = HelloWorldRouter()

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
