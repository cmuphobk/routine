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

}

// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {

    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
    }

    func didTriggerViewWillAppear() {

    }

}
