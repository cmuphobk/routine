import UIKit

final class HelloWorldPresenter: Module, BasePresenter {
    weak var view: HelloWorldViewInput!
    var router: HelloWorldRouterInput!

    var name = R.string.localizable.main_name.key
    var alias = R.string.localizable.main_alias.key
    weak var viewController: UIViewController! {
        return self.view as? UIViewController
    }

    var localizeService: StringServiceInterface!
}

// MARK: - HelloWorldScreenModuleInput
extension HelloWorldPresenter: HelloWorldModuleInput {
    func configureModule() {
        
    }
}

// MARK: - HelloWorldViewOutput
extension HelloWorldPresenter: HelloWorldViewOutput {

    func didTriggerViewReadyEvent() {
        let model = HelloWorldViewModel()
        self.view?.setup(viewModel: model)
    }

    func didTriggerViewWillAppear() {

    }

}
