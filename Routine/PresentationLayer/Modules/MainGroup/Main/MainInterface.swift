import UIKit

protocol MainModuleInput: class {
    func configureModule()
}

protocol MainViewInput: class {
    func setupInitialState()
}

protocol MainViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    
    func rightSwipeAction()
    func leftSwipeAction()
    func menuButtonClicked()
    
    func didTriggerCell(viewModel: RoutineTableViewCellViewModel)
}

protocol MainModuleRouting: class {    
    func openCourseModule()
    
    func rightSwipeAction()
    func leftSwipeAction()
    func menuButtonClicked()
}
