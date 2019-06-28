import UIKit

protocol MainModuleInput: Module {
    func configureModule()
}

protocol MainViewInput: class {
    func setup(viewModel: MainViewModel)
}

protocol MainViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()

    func didTriggerHelloWorld()
}

protocol MainRouterInput: class {
    func didTriggerHelloWorld()
}

protocol MainRouterOutput: class {
    func didTriggerHelloWorld()
}
