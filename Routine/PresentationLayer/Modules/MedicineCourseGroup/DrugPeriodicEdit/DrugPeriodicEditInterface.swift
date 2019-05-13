import Foundation
import UIKit

protocol DrugPeriodicEditModuleInput: class {
    func configureModule(periodType: PeriodCourseType, periodValue: Int)
}

protocol DrugPeriodicEditModuleOutput: class {
    func acceptNewPeriod(newDrugPeriodCourseType: PeriodCourseType, newDrugPeriodCourseValue: Int)
}

protocol DrugPeriodicEditViewInput: class {
    func setupInitialState()
    
    func updateSelectedType(periodType: PeriodCourseType, andValue value: Int)
}

protocol DrugPeriodicEditViewOutput: class {
    var localizeService: StringServiceInterface! { get }
    
    var drugPeriodicEditTableViewFactory: DrugPeriodicEditTableViewFactoryInterface! { get}
    
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func closeModule()
    
    func accept()
    func typeChanged(_ type: PeriodCourseType)
    func valueChanged(_ value: Int)
}

protocol DrugPeriodicEditModuleRouter: class {
    func closeModule()
}

protocol DrugPeriodicEditModuleAnimating: class {
    // empty
}
