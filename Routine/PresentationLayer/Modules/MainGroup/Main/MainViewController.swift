import UIKit
import Stevia

final class MainViewController: RoutineViewController {
    var output: MainViewOutput!
    weak var viewController: UIViewController?

    private lazy var tableViewModel = { () -> RoutineTableViewModel in
        let model = RoutineTableViewModel(routineDelegate: self.output.localizeService)
        model.backgroundColor = ColorProvider.mainModuleColors.blueColor
        model.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 20.0, right: 0.0)
        return model
    }()
    weak private var tableView: RoutineTableView<RoutineTableViewModel>!

    private var tableViewManager: RoutineTableViewManager!
    private var cellViewModels: [RoutineTableViewCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = RoutineTableView()
        self.view.sv(
            tableView
        )
        self.tableView = tableView
        
        self.tableView.configureView(config: self.tableViewModel)
        
        let offsetTableView: CGFloat = 600.0
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0.0, height: offsetTableView))
        view.backgroundColor = ColorProvider.mainModuleColors.whiteColor
        self.tableView.tableFooterView = view
        
        self.tableView.top(0).left(0).right(0).bottom(-offsetTableView)
        
        self.output.didTriggerViewReadyEvent()
        
        self.addRightSwipe(action: #selector(rightSwipeAction))
        self.addLeftSwipe(action: #selector(leftSwipeAction))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.didTriggerViewWillAppear()
        
        AppDelegate.serviceProvider.makeModuleService().navigation?.configureNavigationBarWithColor(ColorProvider.default.blueColor)
        
        AppDelegate.serviceProvider.makeModuleService().navigation?.customBarLeftButtonAction(
            icon: ImageProvider.default.menuIcon.imageWithMask(color: ColorProvider.default.whiteColor),
            target: self,
            action: #selector(menuButtonClicked))
    }
    
    override func localizationSetup() {
        super.localizationSetup()
        
        let title = self.output.localizeService.localizeId(kMainModuleId)
        AppDelegate.serviceProvider.makeModuleService().navigation?.configureNavigationTitle(title)
    }
    
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    func setupInitialState() {
        self.tableViewManager = RoutineTableViewManager(tableView: self.tableView, delegate: self)
        
        self.cellViewModels = self.output.mainTableViewFactory.mainCellViewModels(delegate: self)
        self.tableViewManager.configure(cellViewModels: self.cellViewModels)
        
        self.tableView.separatorStyle = .none
    }
}

// MARK: - RoutineTableViewManagerDelegate
extension MainViewController: RoutineTableViewManagerDelegate {
    
    func didTriggerCell(index: Int, actionType: RoutineActionType) {
        if actionType != .select {
            return
        }
        let cellViewModel = self.cellViewModels[index]
        self.output.didTriggerCell(viewModel: cellViewModel)
        
    }
    
}

// MARK: - SectionCellViewModelDelegate
extension MainViewController: SectionCellViewModelDelegate {
    
    func needUpdate(viewModel: SectionCellViewModel) {
        guard let index = self.cellViewModels.indexOf(viewModel) else { return }
        self.tableViewManager.updateRowAtIndex(index)
    }

}

// MARK: - Private
extension MainViewController {

    @objc private func rightSwipeAction() {
        self.output.rightSwipeAction()
    }
    
    @objc private func leftSwipeAction() {
        self.output.leftSwipeAction()
    }
    
    @objc private func menuButtonClicked() {
        self.output.menuButtonClicked()
    }
    
}
