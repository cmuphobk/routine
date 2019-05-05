
import UIKit
import Stevia

final class MainViewController: LocalizedViewController {
    var output: MainViewOutput!
    weak var viewController: UIViewController?

    private var tableViewModel = LocalizedTableViewModel()
    weak private var tableView: LocalizedTableView<LocalizedTableViewModel>!

    private var tableViewManager: UniversalTableViewManager!
    private var cellViewModels: [LocalizedTableViewCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = LocalizedTableView()
        self.view.sv(
            tableView
        )
        self.tableView = tableView
        
        self.tableViewModel.backgroundColor = ColorProvider.mainModuleColors.blueColor
        self.tableViewModel.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 20.0, right: 0.0)
        
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
        
        self.navigationController?.configureNavigationBarWithColor(ColorProvider.default.blueColor)
        
        self.customBarLeftButtonAction(icon: ImageProvider.default.menuIcon.imageWithMask(color: ColorProvider.default.whiteColor), action: #selector(menuButtonClicked))
    }
    
    override func localizationSetup() {
        super.localizationSetup()
        self.navigationItem.title = AppDelegate.serviceProvider.makeStringService().localizeById(kMainModuleId)
    }
    
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    func setupInitialState() {
        self.tableViewManager = UniversalTableViewManager(tableView: self.tableView, delegate: self)
        
        self.cellViewModels = MainTableViewFactory.mainCellViewModels(delegate: self)
        self.tableViewManager.configure(cellViewModels: self.cellViewModels)
        
        self.tableView.separatorStyle = .none
    }
}

// MARK: - UniversalTableViewManagerDelegate
extension MainViewController: UniversalTableViewManagerDelegate {
    
    func didTriggerCell(index: Int, actionType: TriggerActionType) {
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
