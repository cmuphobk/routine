
import UIKit

protocol RegistrationModuleInput: class {
    func configureModule()
}

protocol RegistrationViewInput: class {
    func setupInitialState()
}

protocol RegistrationViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    
    func didTriggerRegistrationButton(login: String, password: String)
    func didTriggerAuthButton()
    func didTriggerOpenLicense()
    func didTriggerOpenMedicine()
}

protocol RegistrationModuleRouting: class {
    func profileOpenModule(login: String, password: String)
    func openPinCodeModule(login: String, password: String)
    func showErrorMessageWithText(_ string: String)
    func showLoader()
    func hideLoader()
    func closeModule()
    func openLicense()
    func openMedicine()
}
