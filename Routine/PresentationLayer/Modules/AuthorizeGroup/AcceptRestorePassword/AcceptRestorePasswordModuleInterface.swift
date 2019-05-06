import UIKit

protocol AcceptRestorePasswordModuleInput: class {
    func configureModule(login: String)
}

protocol AcceptRestorePasswordViewInput: class {
    func setupInitialState()
}

protocol AcceptRestorePasswordViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    
    func didTriggerRestoreButton(password: String)
    func didTriggerCancelButton()
}

protocol AcceptRestorePasswordModuleRouting: class {
    func showErrorMessageWithText(_ string: String)
    func showLoader()
    func hideLoader()
    func closeModule()
}
