import Foundation
import UIKit

let kDrugTimesEditModuleId = "kDrugTimesEditModule"

class DrugTimesEditPresenter: Module {
    var moduleOutput: DrugTimesEditModuleOutput?
    weak var view: DrugTimesEditViewInput?
    var router: DrugTimesEditModuleRouter!
    
    var name = "DrugTimesEdit_name"
    var alias = "DrugTimesEdit"
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
    
    // Properties
    fileprivate var endingType: EndingCourseType
    fileprivate var endingValue: Int
    
    init() {
        self.endingType = .countUsageDays
        self.endingValue = 1
    }
    
    var localizeService: StringServiceInterface!
}

// MARK: - DrugTimesEditModuleInput
extension DrugTimesEditPresenter: DrugTimesEditModuleInput {
    func configureModule() {
        // empty
    }
}

// MARK: - DrugTimesEditViewOutput
extension DrugTimesEditPresenter: DrugTimesEditViewOutput {
    
    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
        self.view?.updateSelectedType(endingType: self.endingType, andValue: self.endingValue)
    }
    
    func didTriggerViewWillAppear() {
        // empty
    }
    
    func closeModule() {
        self.router.closeModule()
    }
    
    func accept() {
        self.moduleOutput?.acceptNewTimes(newDrugEndingCourseType: self.endingType, newDrugEndingCourseValue: self.endingValue)
        self.closeModule()
    }
    
    func typeChanged(_ type: EndingCourseType) {
        self.endingType = type
        
        switch type {
        case .countUsageNumber:
            self.endingValue = 1
        case .countUsageDays:
            self.endingValue = DaysPeriod.days1.value
        case .endUsageDate:
            let date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
            self.endingValue = Int(date.timeIntervalSince1970 * 1000.0)
        }
        
        self.view?.updateSelectedType(endingType: self.endingType, andValue: self.endingValue)
    }
    
    func valueChanged(_ value: Int) {
        self.endingValue = value
        self.view?.updateSelectedType(endingType: self.endingType, andValue: self.endingValue)
    }
}
