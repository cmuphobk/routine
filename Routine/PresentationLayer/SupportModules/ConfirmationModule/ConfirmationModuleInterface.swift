import UIKit

protocol ConfirmationModuleInput: class {
    func setupInitialState()
    
    func updateCaptionText(_ text: String)
    func updateText(_ text: String)
    func updateTextFieldValue(_ value: String, placeholder: String)
    func updateAcceptButtonText(_ text: String)
    func updateCancelButtonText(_ text: String)
    
    func updateAcceptButtonAvilable(_ avilable: Bool)
}

protocol ConfirmationModuleOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    
    func textFieldValueChanged(newValue: String)
    func addToText(_ text: String)
    func removeAtEnd()
    func acceptButtonDidPressed()
    func cancelButtonDidPressed()
}

protocol ConfirmationModuleModuleOutput: class {
    func confirmWithMessage(_ msg: String)
    func cancelWithoutMessage()
}
