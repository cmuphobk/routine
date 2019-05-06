import UIKit

protocol AuthModuleInput: class {
    func configureModule()
}

protocol AuthViewInput: class {
    func setupInitialState()
}

protocol AuthViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    
    func didTriggerEnterButtonAction()
    func didTriggerRegistrationButtonAction()
    func didTriggerForgotButtonAction()
    
    func didTriggerSetLogin(_ login: String)
    func didTriggerSetPassword(_ password: String)
    
}

protocol AuthModuleRouting: class {
    func openMainModule()
    func openMethodObtainingModuleWithPhone(_ phone: String, andEmail email: String)
    func openRegistrationModule()
    func openPinCodeModule(login: String)
    func openRestorePasswordModule()
    func showErrorMessageWithText(_ string: String)
    func showLoader()
    func hideLoader()
    func closeModule()
}
