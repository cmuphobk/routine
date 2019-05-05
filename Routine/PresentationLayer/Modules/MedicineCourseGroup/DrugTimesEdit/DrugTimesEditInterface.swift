import Foundation
import UIKit

protocol DrugTimesEditModuleInput: class {
    func configureModule()
}

protocol DrugTimesEditModuleOutput: class {
    func acceptNewTimes(newDrugEndingCourseType: EndingCourseType, newDrugEndingCourseValue: Int)
}

protocol DrugTimesEditViewInput: class {
    func setupInitialState()
    func updateSelectedType(endingType: EndingCourseType, andValue: Int)
}

protocol DrugTimesEditViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func closeModule()
    
    func accept()
    func typeChanged(_ type: EndingCourseType)
    func valueChanged(_ value: Int)
}

protocol DrugTimesEditModuleRouter: class {
    func closeModule()
}

protocol DrugTimesEditModuleAnimating: class {
    // empty
}
