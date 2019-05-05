import Foundation
import UIKit

final class DrugPeriodicEditViewController: LocalizedViewController {
    var output: DrugPeriodicEditViewOutput!
    var animator: DrugPeriodicEditModuleAnimating!
    var moduleService: ModuleServiceInterface!
    
    @IBOutlet var typeSelector: StandartPagePicker!
    @IBOutlet weak var tableView: UITableView!
    
    private var tableViewManager: UniversalTableViewManager!
    private var cellViewModels: [LocalizedTableViewCellViewModel]!
    
    private var currentType: PeriodCourseType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.didTriggerViewReadyEvent()
    }
    
    override func localizationSetup() {
        super.localizationSetup()
    }
    
    @objc private func backButtonPressed() {
        self.output.closeModule()
    }
    
    @objc func rightAcceptButton() {
        self.output.accept()
    }
}

// MARK: - DrugPeriodicEditViewInput
extension DrugPeriodicEditViewController: DrugPeriodicEditViewInput {
    
    func setupInitialState() {
        self.navigationController?.configureNavigationBarWithColor(ColorProvider.default.blueColor)
        self.navigationItem.title = AppDelegate.serviceProvider.makeStringService().localizeById("drug_periodic_edit_title")
        
        self.customBarLeftButtonAction(icon: ImageProvider.default.backArrow.imageWithMask(color: ColorProvider.default.whiteColor), action: #selector(backButtonPressed))
        self.customBarRightButtonAction(icon: ImageProvider.drugEditImages.agreeIcon, action: #selector(rightAcceptButton))
        
        self.typeSelector.configureWithPagesNames([PeriodCourseType.weekDays.toString(),
                                                   PeriodCourseType.countDays.toString() ],
                                                  
                                                  height: self.typeSelector.frame.height,
                                                  font: FontProvider.default.standartPages,
                                                  textColor: ColorProvider.default.whiteColor,
                                                  cellsBackgroundColor: ColorProvider.default.blueColor)
        
        self.typeSelector.delegate = self
        self.typeSelector.selectColumnAtIndex(0)
    }
    
    func updateSelectedType(periodType: PeriodCourseType, andValue value: Int) {
                
        self.currentType = periodType
        
        switch periodType {
        case .weekDays:
            self.typeSelector.selectColumnAtIndex(0)
            self.tableView.allowsMultipleSelection = true
            self.cellViewModels = DrugPeriodicEditTableViewFactory.makeDays(withValue: value)
            self.tableViewManager = UniversalTableViewManager(tableView: self.tableView, delegate: self)
            self.tableViewManager.configure(cellViewModels: self.cellViewModels)
        case .countDays:
            self.typeSelector.selectColumnAtIndex(1)
            self.tableView.allowsMultipleSelection = false
            self.cellViewModels = DrugPeriodicEditTableViewFactory.makeCountDays(withValue: value)
            self.tableViewManager = UniversalTableViewManager(tableView: self.tableView, delegate: self)
            self.tableViewManager.configure(cellViewModels: self.cellViewModels)
        }
    }
    
}

// MARK: - StandartPagePickerDelegate
extension DrugPeriodicEditViewController: StandartPagePickerDelegate {
    
    func columnDidPressed(index: Int) {
        guard let newType = PeriodCourseType.fromValue(index+1) else { return }
        self.output.typeChanged(newType)
    }
    
}

// MARK: - UniversalTableViewManager
extension DrugPeriodicEditViewController: UniversalTableViewManagerDelegate {
    
    func didTriggerCell(index: Int, actionType: TriggerActionType) {
        guard let currentType = self.currentType else {
            return
        }
        
        switch currentType {
        case .weekDays:
            
            if actionType == .select && index == self.tableViewManager.count - 1 {
                for item in 0..<self.tableViewManager.count - 1 where !self.tableViewManager.selectedRows().contains(item) {
                    self.tableViewManager.selectRow(item)
//                    self.tableViewManager.updateRowAtIndex(item)
                }
            } else if actionType == .select && index != self.tableViewManager.count - 1 {
                if self.daysValue() == DayOfWeek.allDay {
                    self.tableViewManager.selectRow(self.tableViewManager.count - 1)
//                    self.tableViewManager.updateRowAtIndex(self.tableViewManager.count - 1)
                }
            } else if actionType == .deselect && index != self.tableViewManager.count - 1 {
                if self.daysValue() != DayOfWeek.allDay {
                    self.tableViewManager.deselectRow(self.tableViewManager.count - 1)
//                    self.tableViewManager.updateRowAtIndex(self.tableViewManager.count - 1)
                }
            }
        
            //FIXME: неправильно работает выделение
            self.output.valueChanged(self.daysValue())
        case .countDays:
            let daysCount = DaysPeriod.fromValue(index+1)
            if let daysCountValue = daysCount?.value {
                self.output.valueChanged(daysCountValue)
            }
        }
    }
    
}

// MARK: - Private
extension DrugPeriodicEditViewController {
    
    private func daysValue() -> Int {
        var selectedDays: UInt8 = 0
        for item in self.tableViewManager.selectedRows() {
            if let day = DayOfWeek.dayOfWeekFromWeekday(item+1) {
                selectedDays += day.rawValue
            }
        }
        return Int(selectedDays)
    }
    
}
