import Foundation
import UIKit

protocol DrugTimesEditModuleInput: ModuleInput {
    func configureModule()
}

protocol DrugTimesEditModuleOutput: ModuleOutput {
    func acceptNewTimes(newDrugEndingCourseType: EndingCourseType, newDrugEndingCourseValue: Int)
}

protocol DrugTimesEditViewInput: ViewInput {
    func updateSelectedType(endingType: EndingCourseType, andValue: Int)
}

protocol DrugTimesEditViewOutput: ViewOutput {
    var localizeService: StringServiceInterface! { get }
    
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func closeModule()
    
    func accept()
    func typeChanged(_ type: EndingCourseType)
    func valueChanged(_ value: Int)
}

protocol DrugTimesEditRouterInput: RouterInput {
    func closeModule()
}

protocol DrugTimesEditRouterOutput: RouterOutput {
    
}
