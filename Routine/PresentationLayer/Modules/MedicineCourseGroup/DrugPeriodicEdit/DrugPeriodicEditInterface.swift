import Foundation
import UIKit

protocol DrugPeriodicEditModuleInput: ModuleInput {
    func configureModule(periodType: PeriodCourseType, periodValue: Int)
}

protocol DrugPeriodicEditModuleOutput: ModuleOutput {
    func acceptNewPeriod(newDrugPeriodCourseType: PeriodCourseType, newDrugPeriodCourseValue: Int)
}

protocol DrugPeriodicEditViewInput: ViewInput {    
    func updateSelectedType(periodType: PeriodCourseType, andValue value: Int)
}

protocol DrugPeriodicEditViewOutput: ViewOutput {
    var localizeService: StringServiceInterface! { get }
    
    var drugPeriodicEditTableViewFactory: DrugPeriodicEditTableViewFactoryInterface! { get}
    
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func closeModule()
    
    func accept()
    func typeChanged(_ type: PeriodCourseType)
    func valueChanged(_ value: Int)
}

protocol DrugPeriodicEditRouterInput: RouterInput {
    func closeModule()
}

protocol DrugPeriodicEditRouterOutput: RouterOutput {
    
}
