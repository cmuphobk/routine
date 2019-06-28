import UIKit

final class MainPresenter: Module, BasePresenter {
    weak var view: MainViewInput!
    var router: MainRouterInput!

    var name = R.string.localizable.main_name.key
    var alias = R.string.localizable.main_alias.key
    weak var viewController: UIViewController! {
        return self.view as? UIViewController
    }

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
