import UIKit

var mainDescription = ModuleDescription(name: R.string.localizable.main_name.key,
                                    description: R.string.localizable.main_alias.key)

final class MainPresenter: Module, BasePresenter {
    var description = mainDescription
    weak var viewController: UIViewController! {
        return self.view as? UIViewController
    }

    weak var view: MainViewInput!
    var router: MainRouterInput!

    var localizeService: StringServiceInterface!
}

// MARK: - MainScreenModuleInput
extension MainPresenter: MainModuleInput {
    func configureModule() {
    }
}

// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {

    func didTriggerViewReadyEvent() {
        let title = self.localizeService.localizeId(R.string.localizable.go_to_hello_world.key)
        let model = MainViewModel(titleButton: title)
        self.view?.setup(viewModel: model)
    }

    func didTriggerViewWillAppear() {

    }
    func didTriggerHelloWorld() {
        self.router.didTriggerHelloWorld()
    }
}
