import UIKit

protocol MainModuleInput: ModuleInput {
    func configureModule()
}

protocol MainViewInput: ViewInput {
}

protocol MainViewOutput: ViewOutput {
    var localizeService: StringServiceInterface! { get }

    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
}

protocol MainRouterInput: RouterInput {
}

protocol MainRouterOutput: RouterOutput {
}
