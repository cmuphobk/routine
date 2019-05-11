import Foundation
import UIKit

final class DrugTimesEditViewController: RoutineViewController {
    var output: DrugTimesEditViewOutput!
    var animator: DrugTimesEditModuleAnimating!
    var moduleService: ModuleServiceInterface!
    
    @IBOutlet weak var typeSelector: StandartPagePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    fileprivate var pickerDareSourceLeft: [Int] = []
    fileprivate var pickerDareSourceRight: [String] = []
    
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
    
    @IBAction func datePickerDidSelectRow(_ sender: Any) {
        let date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self.datePicker.date)!
        self.output.valueChanged( Int(date.timeIntervalSince1970 * 1000.0) )
    }
}

// MARK: - DrugTimesEditViewInput
extension DrugTimesEditViewController: DrugTimesEditViewInput {
    
    func setupInitialState() {
        AppDelegate.serviceProvider.makeModuleService().navigation?.configureNavigationBarWithColor(ColorProvider.default.blueColor)
        
        let title = AppDelegate.serviceProvider.makeStringService().localizeById("drug_times_edit_title")
        AppDelegate.serviceProvider.makeModuleService().navigation?.configureNavigationTitle(title)
        
        AppDelegate.serviceProvider.makeModuleService().navigation?.customBarLeftButtonAction(
            icon: ImageProvider.default.backArrow.imageWithMask(color: ColorProvider.default.whiteColor),
            target: self,
            action: #selector(backButtonPressed))
        
        AppDelegate.serviceProvider.makeModuleService().navigation?.customBarRightButtonAction(
            icon: ImageProvider.drugEditImages.agreeIcon,
            target: self,
            action: #selector(rightAcceptButton))
        
        self.typeSelector.configureWithPagesNames([EndingCourseType.endUsageDate.toString(),
                                                   EndingCourseType.countUsageDays.toString(),
                                                   EndingCourseType.countUsageNumber.toString()],
                                                  
                                                  height: self.typeSelector.frame.height,
                                                  font: FontProvider.default.standartPages,
                                                  textColor: ColorProvider.default.whiteColor,
                                                  cellsBackgroundColor: ColorProvider.default.blueColor)
        
        self.typeSelector.delegate = self
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.datePicker.datePickerMode = .date
        
        self.typeSelector.selectColumnAtIndex(0)
        self.datePicker.isHidden = true
    }
    
    func updateSelectedType(endingType: EndingCourseType, andValue value: Int) {
        self.pickerDareSourceLeft.removeAll()
        self.pickerDareSourceRight.removeAll()
        
        switch endingType {
        case .countUsageNumber:
            self.typeSelector.selectColumnAtIndex(0)
            self.pickerView.isHidden = false
            self.datePicker.isHidden = true
            
            for value in (1...100) {
                self.pickerDareSourceLeft += [value]
            }
            self.pickerDareSourceRight = [AppDelegate.serviceProvider.makeStringService().pluralsLocalizeByIds(str1: "usage_1", str24: "usage_2_4", str5: "usage_5", count: value)]
            
            self.pickerView.reloadAllComponents()
            self.pickerView.selectRow(value-1, inComponent: 0, animated: false)
            self.pickerView.selectRow(0, inComponent: 1, animated: false)
            
        case .countUsageDays:
            self.typeSelector.selectColumnAtIndex(1)
            self.pickerView.isHidden = false
            self.datePicker.isHidden = true
            
            for value in (1...100) {
                self.pickerDareSourceLeft += [value]
            }
            self.pickerDareSourceRight = [AppDelegate.serviceProvider.makeStringService().pluralsLocalizeByIds(str1: "days1", str24: "days2_4", str5: "days5", count: value)]
            
            self.pickerView.reloadAllComponents()
            self.pickerView.selectRow(value-1, inComponent: 0, animated: false)
            self.pickerView.selectRow(0, inComponent: 1, animated: false)
            
        case .endUsageDate:
            self.typeSelector.selectColumnAtIndex(2)
            self.pickerView.isHidden = true
            self.datePicker.isHidden = false
            
            let date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date(timeIntervalSince1970: Double(value / 1000)))!
            self.datePicker.date = date
        }
    }
}

// MARK: - UIPickerViewDataSource
extension DrugTimesEditViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.pickerDareSourceLeft.count
        } else {
            return self.pickerDareSourceRight.count
        }
    }
    
}

// MARK: - UIPickerViewDelegate
extension DrugTimesEditViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(self.pickerDareSourceLeft[row])
        } else {
            return self.pickerDareSourceRight[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.output.valueChanged( self.pickerDareSourceLeft[row] )
    }
}

// MARK: - StandartPagePickerDelegate
extension DrugTimesEditViewController: StandartPagePickerDelegate {
    
    func columnDidPressed(index: Int) {
        guard let newType = EndingCourseType.fromValue(index+1) else { return }
        
        self.output.typeChanged(newType)
    }
    
}
