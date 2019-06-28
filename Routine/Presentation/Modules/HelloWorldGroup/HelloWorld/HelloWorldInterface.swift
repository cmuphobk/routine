import UIKit

protocol HelloWorldModuleInput: Module {
    func configureModule()
}

protocol HelloWorldViewInput: class {
    func setup(viewModel: HelloWorldViewModel)
}

protocol HelloWorldViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
}

protocol HelloWorldRouterInput: class {
}

protocol HelloWorldRouterOutput: class {
}
