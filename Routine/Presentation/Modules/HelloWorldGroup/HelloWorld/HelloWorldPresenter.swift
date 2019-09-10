import UIKit

let helloWorldDescription = ModuleDescription(name: R.string.localizable.hello_world_name.key,
                                              description: R.string.localizable.hello_world_alias.key)

final class HelloWorldPresenter: Module, BasePresenter {
    var description = helloWorldDescription
    weak var viewController: UIViewController! {
        return self.view as? UIViewController
    }

    weak var view: HelloWorldViewInput!
    var router: HelloWorldRouterInput!

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
