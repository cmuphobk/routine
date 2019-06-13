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

    func rightSwipeAction()
    func leftSwipeAction()

    func configureNavigationBar(title: String)
}

protocol MainRouterInput: RouterInput {
    func rightSwipeAction()
    func leftSwipeAction()

    func configureNavigationBar(title: String)
}

protocol MainRouterOutput: RouterOutput {

}
