
import UIKit

let kMethodObtainingModuleId = "method_obtaining_name"

final class MethodObtainingPresenter: Module {
    weak var view: MethodObtainingViewInput?
    var router: MethodObtainingModuleRouting!
    
    var name = kMethodObtainingModuleId
    var alias = "method_obtaining_alias"
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
    
    private var number: String!
    private var email: String!
}

// MARK: - MethodObtainingModuleInput
extension MethodObtainingPresenter: MethodObtainingModuleInput {
    
    func configureModule() {
        
    }
    
    func configureModuleWithNumber(_ number: String, andEmail email: String) {
        
        self.number = number
        self.email = email
        
    }
    
}

// MARK: - MethodObtainingViewOutput
extension MethodObtainingPresenter: MethodObtainingViewOutput {

    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
        
        self.view?.configureModuleWithNumber(self.number, andEmail: self.email)
    }
    
    func didTriggerViewWillAppear() {
        
    }
    
    func didTriggerEnterButtonWithLogin(_ login: String) {
        
        self.router.openPinCodeModule(login: login)
        
    }
    
    func didTriggerCancelButton() {
        
        self.router.closeModule()
        
    }
    
}
