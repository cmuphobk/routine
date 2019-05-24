import UIKit

let kMainModuleId = "main_name"
let kMainModuleAlias = "main_alias"

final class MainPresenter: Module, BasePresenter {
    weak var view: MainViewInput!
    var router: MainRouterInput!
    
    var name = kMainModuleId
    var alias = kMainModuleAlias
    weak var viewController: UIViewController! {
        return self.view as? UIViewController
    }
    
    var localizeService: StringServiceInterface!
    var mainTableViewFactory: MainTableViewFactoryInterface!
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
    
    func didTriggerCell(viewModel: RoutineTableViewCellViewModel) {

    }
    
    func rightSwipeAction() {
        self.router.rightSwipeAction()
    }
    
    func leftSwipeAction() {
        self.router.leftSwipeAction()
    }
    
    func configureNavigationBar(title: String) {
        self.router.configureNavigationBar(title: title)
    }
    
}
