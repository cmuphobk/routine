
import UIKit

protocol RestorePasswordModuleInput: class {
    func configureModule()
}

protocol RestorePasswordViewInput: class {
    func setupInitialState()
}

protocol RestorePasswordViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    
    func didTriggerRestoreButtonWithLogin(_ login: String)
    func didTriggerCancelButton()
}

protocol RestorePasswordModuleRouting: class {
    func openPinCodeModule(login: String)
    func showErrorMessageWithText(_ string: String)
    func showLoader()
    func hideLoader()
    func closeModule()
}
