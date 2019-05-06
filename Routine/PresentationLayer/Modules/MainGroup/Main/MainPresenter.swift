import UIKit

let kMainModuleId = "main_name"
let kMainModuleAlias = "main_alias"

final class MainPresenter: Module {
    weak var view: MainViewInput?
    var router: MainModuleRouting!
    
    var name = kMainModuleId
    var alias = kMainModuleAlias
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
}

// MARK: - MainScreenModuleInput
extension MainPresenter: MainModuleInput {
    
    func configureModule() {
        
    }
    
}

// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {
    
    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
    }
    
    func didTriggerViewWillAppear() {
        
    }
    
    func didTriggerCell(viewModel: RoutineTableViewCellViewModel) {
        switch viewModel.viewName {
        case kMedicineCourseModuleId:
            self.router.openCourseModule()
        default:
            return
        }
    }
    
    func rightSwipeAction() {
        self.router.rightSwipeAction()
    }
    
    func leftSwipeAction() {
        self.router.leftSwipeAction()
    }
    
    func menuButtonClicked() {
        self.router.menuButtonClicked()
    }
    
}
