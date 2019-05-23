import UIKit

enum MedicineCourseGroupType: String {
    case medicineCourseNow = "medicine_course_now"
    case medicineCourseArchive =  "medicine_course_archive"
    
    var index: NSInteger {
        if self == .medicineCourseNow {
            return 0
        } else if self == .medicineCourseArchive {
            return 1
        } else {
            //unused (not called)
            return 0
        }
    }
    
    static func medicineCourseTypeByIndex(_ index: Int) -> MedicineCourseGroupType? {
        if index == 0 {
            return MedicineCourseGroupType.medicineCourseNow
        } else if index == 1 {
            return MedicineCourseGroupType.medicineCourseArchive
        } else {
            return nil
        }
    }
}

final class MedicineCourseViewController: RoutineViewController, BaseView {
    
    var output: MedicineCourseViewOutput!
    var moduleService: ModuleServiceInterface!
    
    @IBOutlet weak var contentView: UIView!
    
    private lazy var tableViewModel = { () -> RoutineTableViewModel in
        return RoutineTableViewModel(routineDelegate: self.output.localizeService)
    }()
    
    weak private var tableView: RoutineTableView<RoutineTableViewModel>!
    
    @IBOutlet weak private var pagesView: StandartPagePicker!
    @IBOutlet weak private var placeholderLabel: UILabel!
    
    weak private var modalView: StandartModalView!
    
    private var cellViewModels: [RoutineTableViewCellViewModel] = []
    private var tableViewManager: RoutineTableViewManager!
    
    private var selectedMedicineCourseType: MedicineCourseGroupType  = .medicineCourseNow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = RoutineTableView()
        self.contentView.sv(
            tableView
        )
        
        self.tableView = tableView
        
        self.tableView.configureView(config: self.tableViewModel)
        
        self.tableView.top(44).bottom(0).left(0).right(0)
        
        output.didTriggerViewReadyEvent()
        
        self.view.backgroundColor = ColorProvider.medicineCourseColors.screenBackgroundColor
        
        self.addRightSwipe(action: #selector(rightSwipeAction))
        self.addLeftSwipe(action: #selector(leftSwipeAction))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.didTriggerViewWillAppear()
        
//        AppDelegate.serviceProvider.makeModuleService().navigation?.configureNavigationBarWithColor(ColorProvider.default.blueColor)
        
//        AppDelegate.serviceProvider.makeModuleService().navigation?.customBarLeftButtonAction(
//            icon: ImageProvider.default.backArrow.imageWithMask(color: ColorProvider.default.whiteColor),
//            target: self,
//            action: #selector(backButtonPressed))
//
//        AppDelegate.serviceProvider.makeModuleService().navigation?.customBarRightButtonAction(
//            icon: ImageProvider.medicineCourseImages.plusIcon,
//            target: self,
//            action: #selector(createCourseButtonAction))
    }
    
    override func localizationSetup() {
        super.localizationSetup()
        let title = self.output.localizeService.localizeId(kMedicineCourseModuleId)
//        AppDelegate.serviceProvider.makeModuleService().navigation?.configureNavigationTitle(title)
        
        self.placeholderLabel.font = FontProvider.default.forosRegular18
        self.placeholderLabel.textColor = ColorProvider.default.lightGrayColor
        self.placeholderLabel.text = self.output.localizeService.localizeId("med_cource_empty_placeholder")
        self.contentView.bringSubviewToFront(self.placeholderLabel)
    }
    
    @objc private func backButtonPressed() {
        self.output.closeModule()
    }
}

// MARK: - MedicineCourseViewInput
extension MedicineCourseViewController: MedicineCourseViewInput {
    
    func setupInitialState() {
        self.tableViewManager = RoutineTableViewManager(tableView: self.tableView, delegate: self)
        
        self.pagesView.configureWithPagesNames([MedicineCourseGroupType.medicineCourseNow.rawValue, MedicineCourseGroupType.medicineCourseArchive.rawValue], height: self.pagesView.frame.height, font: FontProvider.default.standartPages, textColor: ColorProvider.default.whiteColor, cellsBackgroundColor: ColorProvider.default.blueColor)
        self.pagesView.delegate = self
        self.pagesView.selectColumnAtIndex(self.selectedMedicineCourseType.index)
        
        self.placeholderLabel.numberOfLines = 0
        self.placeholderLabel.textAlignment = .center
    
    }
    
    func updateTableView(models: [MedicineCourse], isArchive: Bool) {
        self.cellViewModels = self.output.medicineCourseTableViewFactory.medicineCourseCellViewModels(models: models, isArchive: isArchive, delegate: self)
        self.tableViewManager.configure(cellViewModels: self.cellViewModels)
        self.placeholderLabel.isHidden = (self.cellViewModels.count > 0)
    }
    
    func reloadRowAtIndex(_ index: Int, medCourse: MedicineCourse) {
        self.cellViewModels[index] = self.output.medicineCourseTableViewFactory.medicineCourseCellViewModel(medicineCourse: medCourse, isArchive: false, delegate: self)
        self.tableViewManager.configure(cellViewModels: self.cellViewModels, reloadData: false)
        self.tableViewManager.updateRowAtIndex(index)
        self.placeholderLabel.isHidden = (self.cellViewModels.count > 0)
    }
    
    func deleteRowAtIndex(_ index: Int) {
        self.cellViewModels.remove(at: index)
        self.tableViewManager.configure(cellViewModels: self.cellViewModels, reloadData: false)
        self.tableViewManager.deleteRowAtIndex(index)
        self.placeholderLabel.isHidden = (self.cellViewModels.count > 0)
    }
    
    func openModal(view: UIView, completion: @escaping (Bool, StandartModalView) -> Void) {
        
        if self.modalView == nil {
            let modalView = StandartModalView()
            modalView.delegate = self
            
            modalView.frame = CGRect.zero
            
            self.modalView = modalView
            
            if !self.modalView.isDescendant(of: view) {
                view.addSubview(self.modalView)
                self.modalView.layoutIfNeeded()
            }
        }
        
        self.showModalAnimate(self.modalView, toFrame: view.bounds) { [unowned self] (isCompletion) in
            completion(isCompletion, self.modalView)
        }
        
    }
    
    func closeModal(completion: @escaping (Bool) -> Void) {
        
        self.closeModalAnimate(self.modalView) { (isCompletion) in
            completion(isCompletion)
        }
        
    }
    
}

// MARK: - StandartModalViewDelegate
extension MedicineCourseViewController: StandartModalViewDelegate {
    
    func didTriggerCloseModalAction(modal: StandartModalView) {
        
        self.closeModalAnimate(self.modalView) { (_) in }
        
    }
    
}

// MARK: - RoutineTableViewManager
extension MedicineCourseViewController: RoutineTableViewManagerDelegate {
    func didTriggerCell(index: Int, actionType: RoutineActionType) {
        if actionType != .select {
            return
        }
        self.output.rowDidPressed(index: index)
        
    }
}

// MARK: - MedicineCourseCellProtocol
extension MedicineCourseViewController: MedicineCourseCellProtocol {
    
    func rowDidRenamed(cellObj: MedicineCourseCellViewModel) {
        guard let index = self.cellViewModels.indexOf(cellObj) else { return }
        self.output.rowDidRenamed(index: index)
    }
    
    func rowDidRemoved(cellObj: MedicineCourseCellViewModel) {
        guard let index = self.cellViewModels.indexOf(cellObj) else { return }
        self.output.rowDidRemoved(index: index)
    }
    
}

// MARK: - StandartPagePickerDelegate
extension MedicineCourseViewController: StandartPagePickerDelegate {
    
    func columnDidPressed(index: Int) {
        guard let type = MedicineCourseGroupType.medicineCourseTypeByIndex(index) else {
            return
        }
        
        self.selectedMedicineCourseType = type
        self.pagesView.selectColumnAtIndex(self.selectedMedicineCourseType.index)
        self.output.didTriggerSelectMedicineGroupType(self.selectedMedicineCourseType)
    }
    
}

// MARK: - Private
extension MedicineCourseViewController {
    
    private func showModalAnimate(_ modal: StandartModalView, toFrame: CGRect, completion: @escaping (Bool) -> Void) {
        
        modal.center = CGPoint(x: toFrame.width/2, y: toFrame.height/2)
        for element in modal.modalContainer.subviews {
            element.alpha = 0.0
        }
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseIn,
                       animations: {
            
            modal.bounds = toFrame
            modal.setNeedsLayout()
            
        }, completion: { (isCompletion) in
            
            for element in modal.modalContainer.subviews {
                element.alpha = 1.0
            }
            
            completion(isCompletion)
            
        })
        
    }
    
    private func closeModalAnimate(_ modal: StandartModalView, completion: @escaping (Bool) -> Void) {
        
        for element in modal.modalContainer.subviews {
            element.alpha = 0.0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            
            modal.bounds = CGRect.zero
            modal.setNeedsLayout()
            
        }, completion: { (isCompletion) in
            
            completion(isCompletion)
            
        })
        
    }
    
    @objc private func createCourseButtonAction() {
        
        self.output.didTriggerOpenCreateCourseModal()
    }
    
    @objc private func menuButtonClicked() {
//        self.moduleService.navigation?.triggerMenu()
    }
    
    @objc private func rightSwipeAction() {
//        self.moduleService.navigation?.openMenu()
    }
    
    @objc private func leftSwipeAction() {
//        self.moduleService.navigation?.hideMenu()
    }
    
}
