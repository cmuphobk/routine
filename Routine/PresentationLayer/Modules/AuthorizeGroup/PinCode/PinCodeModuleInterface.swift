import UIKit

protocol PinCodeModuleInput: class {
    func configureWithLogin(_ login: String, password: String?, pinCodeInitiator: PinCodeInitiator)
}

protocol PinCodeModuleOutput: class {
    func didRecieveLoginToken(_ loginToken: String)
}

protocol PinCodeViewInput: class {
    func setupInitialState()
    func configureWithLogin(_ login: String)
    
    func openModal(view: UIView, completion: @escaping (Bool, StandartModalView) -> Void)
    func closeModal(completion: @escaping (Bool) -> Void)
}

protocol PinCodeViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    
    func didTriggerCancelButton()
    func didTriggerEnterPinCode(_ pinCode: String?)
    func didTriggerResendButton()
    
    func didTriggerCloseModalFromBlurredBackground()
}

protocol PinCodeModuleRouting: class {
    func profileOpenModule(login: String, password: String)
    func openErrorCodeInStandartModal(_ modal: StandartModalView) -> ErrorCodeViewController?
    func authOpenModule()
    func openAcceptRestoreModule(login: String)
    func showSuccessMessageWithText(_ string: String)
    func showErrorMessageWithText(_ string: String)
    func showLoader()
    func hideLoader()
    func containerForModal() -> ModalContainer?
}
