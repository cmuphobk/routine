
import UIKit

protocol MethodObtainingModuleInput: class {
    func configureModule()
    
    func configureModuleWithNumber(_ number: String, andEmail email: String)
}

protocol MethodObtainingViewInput: class {
    func setupInitialState()
    
    func configureModuleWithNumber(_ number: String, andEmail email: String)
}

protocol MethodObtainingViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    
    func didTriggerEnterButtonWithLogin(_ login: String)
    func didTriggerCancelButton()
}

protocol MethodObtainingModuleRouting: class {
    func openPinCodeModule(login: String)
    func closeModule()
}
