import UIKit

final class DrugsListViewController: RoutineViewController {
    var output: DrugsListViewOutput!
    var animator: DrugsListAnimator!
    var moduleService: ModuleServiceInterface!
    
    @IBOutlet weak private var contentView: UIView!
    
    private var tableViewModel = { () -> RoutineTableViewModel in
        return RoutineTableViewModel()
    }()
    
    weak private var tableView: RoutineTableView<RoutineTableViewModel>!
    
    @IBOutlet weak private var placeholderLabel: UILabel!
    
    private var cellViewModels: [RoutineTableViewCellViewModel] = []
    private var tableViewManager: RoutineTableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = RoutineTableView()
        self.contentView.sv(
            tableView
        )

        self.tableView = tableView
        
        self.tableView.configureView(config: self.tableViewModel)
        
        self.tableView.fillContainer()
        
        self.output.didTriggerViewReadyEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.didTriggerViewWillAppear()
        
        AppDelegate.serviceProvider.makeModuleService().navigation?.configureNavigationBarWithColor(ColorProvider.default.blueColor)
        
        AppDelegate.serviceProvider.makeModuleService().navigation?.customBarLeftButtonAction(
            icon: ImageProvider.default.backArrow.imageWithMask(color: ColorProvider.default.whiteColor),
            target: self,
            action: #selector(backButtonPressed))
    }
    
    override func localizationSetup() {
        super.localizationSetup()
        
        self.placeholderLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("drug_list_empty_placeholder")
        self.contentView.bringSubviewToFront(self.placeholderLabel)
    }
    
    @objc private func backButtonPressed() {
        self.output.backButtonPressed()
    }
    
    @objc private func createDrugButtonAction() {
        self.output.createDrugButtonDidPressed()
    }
}

// MARK: - DrugsListViewInput
extension DrugsListViewController: DrugsListViewInput {
    func setupInitialState() {
        self.tableViewManager = RoutineTableViewManager(tableView: self.tableView, delegate: self)
        
        self.contentView.backgroundColor = ColorProvider.medicineCourseColors.screenBackgroundColor
        
        self.placeholderLabel.font = FontProvider.default.forosRegular18
        self.placeholderLabel.textColor = ColorProvider.default.lightGrayColor
        self.placeholderLabel.numberOfLines = 0
        self.placeholderLabel.textAlignment = .center
    }
    
    func updateNavTitle(_ text: String) {
        AppDelegate.serviceProvider.makeModuleService().navigation?.configureNavigationTitle(text)
    }
    
    func enableCreateButton() {
        AppDelegate.serviceProvider.makeModuleService().navigation?.customBarRightButtonAction(
            icon: ImageProvider.drugsListImages.createDrugIcon,
            target: self,
            action: #selector(createDrugButtonAction))
    }
    
    func updateTableViewWithMedicineCourse(_ medicineCourse: MedicineCourse) {
        self.cellViewModels = DrugsListTableViewFactory.drugsListCellViewModels(model: medicineCourse)
        self.tableViewManager.configure(cellViewModels: self.cellViewModels)
        self.placeholderLabel.isHidden = (self.cellViewModels.count > 0)
    }
    
    func updateDrug(_ drug: MedicineDrug, forIndex: Int) {
        if self.cellViewModels.indices.contains(forIndex) {
            self.cellViewModels[forIndex] = DrugsListTableViewFactory.drugsListCellViewModel(model: drug)
            self.tableViewManager.configure(cellViewModels: self.cellViewModels, reloadData: false)
            self.tableViewManager.updateRowAtIndex(forIndex)
        } else {
            self.cellViewModels.append(DrugsListTableViewFactory.drugsListCellViewModel(model: drug))
            self.tableViewManager.configure(cellViewModels: self.cellViewModels, reloadData: false)
            self.tableViewManager.insertRowToIndex(forIndex)
        }
        self.placeholderLabel.isHidden = (self.cellViewModels.count > 0)
    }
    
    func removeDrug(_ drug: MedicineDrug, forIndex: Int) {
        self.cellViewModels.remove(at: forIndex)
        self.tableViewManager.configure(cellViewModels: self.cellViewModels, reloadData: false)
        self.tableViewManager.deleteRowAtIndex(forIndex)
        self.placeholderLabel.isHidden = (self.cellViewModels.count > 0)
    }
}

// MARK: - RoutineTableViewManager
extension DrugsListViewController: RoutineTableViewManagerDelegate {
    func didTriggerCell(index: Int, actionType: RoutineActionType) {
        if actionType != .select {
            return
        }
        self.output.rowDidPressed(index: index)
        
    }
}
