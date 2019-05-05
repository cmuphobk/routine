import Foundation
import UIKit

let kDrugPeriodicEditModuleId = "kDrugPeriodicEdit"

class DrugPeriodicEditPresenter: Module {
    var moduleOutput: DrugPeriodicEditModuleOutput?
    weak var view: DrugPeriodicEditViewInput?
    var router: DrugPeriodicEditModuleRouter!
    
    var name = "DrugPeriodicEdit_name"
    var alias = "DrugPeriodicEdit"
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
    
    // Properties
    var periodType: PeriodCourseType
    var periodValue: Int
    
    init() {
        self.periodType = PeriodCourseType.countDays
        self.periodValue = 0
    }
}

// MARK: - DrugTimesEditModuleInput
extension DrugPeriodicEditPresenter: DrugPeriodicEditModuleInput {
    
    func configureModule(periodType: PeriodCourseType, periodValue: Int) {
        self.periodType = periodType
        self.periodValue = periodValue
    }
    
}

// MARK: - DrugTimesEditViewOutput
extension DrugPeriodicEditPresenter: DrugPeriodicEditViewOutput {

    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
        self.view?.updateSelectedType(periodType: self.periodType, andValue: self.periodValue)
    }
    
    func didTriggerViewWillAppear() {
        // empty
    }
    
    func closeModule() {
        self.router.closeModule()
    }
    
    func accept() {
        self.moduleOutput?.acceptNewPeriod(newDrugPeriodCourseType: self.periodType, newDrugPeriodCourseValue: self.periodValue)
        self.router.closeModule()
    }
    
    func typeChanged(_ type: PeriodCourseType) {
        self.periodType = type
        self.view?.updateSelectedType(periodType: self.periodType, andValue: 0)
    }
    
    func valueChanged(_ value: Int) {
        self.periodValue = value
    }
}
