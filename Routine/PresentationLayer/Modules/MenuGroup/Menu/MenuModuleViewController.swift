import UIKit

class MenuModuleViewController: RoutineViewController {
    
    var output: MenuModuleViewOutput!
    
    weak var viewController: UIViewController?
    
    private var tableViewModel = { () -> RoutineTableViewModel in 
        let model = RoutineTableViewModel()
        model.backgroundColor = ColorProvider.default.clearColor
        return model
    }()
    
    weak private var tableView: RoutineTableView<RoutineTableViewModel>!
    
    private var viewModels: [MenuModuleCellViewModel] = []
    private var currentSelectedCellIndex: Int = 0
    private let tableViewOffset: CGFloat = 60.0
    
    private var tableViewManager: RoutineTableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = RoutineTableView()
        self.view.sv(
            tableView
        )
        self.tableView = tableView
        
        self.tableView.configureView(config: self.tableViewModel)
        
        self.tableView.fillContainer()
        
        output.didTriggerViewReadyEvent()
        
        self.addLeftSwipe(action: #selector(leftSwipeAction))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.didTriggerViewWillAppear()
    }

    override func localizationSetup() {
        super.localizationSetup()
    }
    
    @objc private func leftSwipeAction() {
        self.output.didTriggerHideMenu()
    }

}

// MARK: - MenuModuleViewInput
extension MenuModuleViewController: MenuModuleViewInput {
    
    func setupInitialState() {
        
        self.tableViewManager = RoutineTableViewManager(tableView: self.tableView, delegate: self)
        
        self.tableView.contentInset = UIEdgeInsets(top: self.tableViewOffset, left: 0, bottom: 0, right: 0)
        self.view.backgroundColor = ColorProvider.default.blueColor
        self.tableView.backgroundColor = UIColor.clear
    }
    
    func configureViewWithItemTitles(_ itemTitles: [String]) {
        self.currentSelectedCellIndex = 0
        self.viewModels = itemTitles.enumerated().map { (name) -> MenuModuleCellViewModel in
            let model = MenuModuleCellViewModel()
            model.text = name.element
            model.backgroundColor = ColorProvider.menuColors.menuCellBackgroundColor
            return model
        }
        self.tableViewManager.configure(cellViewModels: self.viewModels)
    
        self.tableViewManager.selectRow(self.currentSelectedCellIndex)
    }
    
    func selectMenuItemWithName(_ moduleName: String) {
        let enumerate = self.viewModels.enumerated().first { $0.element.text == moduleName }
    
        self.tableViewManager.deselectRow(self.currentSelectedCellIndex)
        self.currentSelectedCellIndex = enumerate?.offset ?? 0
        self.tableViewManager.selectRow(self.currentSelectedCellIndex)
    }
    
}

// MARK: - RoutineTableViewManager
extension MenuModuleViewController: RoutineTableViewManagerDelegate {
    
    func didTriggerCell(index: Int, actionType: RoutineActionType) {
        if actionType != .select {
            return
        }
        
        self.output.didTriggerSelectRow(index)
        self.output.didTriggerHideMenu()
        
    }
    
}
