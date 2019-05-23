import UIKit

protocol ConfirmationViewInput: ViewInput {    
    func updateCaptionText(_ text: String)
    func updateText(_ text: String)
    func updateTextFieldValue(_ value: String, placeholder: String)
    func updateAcceptButtonText(_ text: String)
    func updateCancelButtonText(_ text: String)
    
    func updateAcceptButtonAvilable(_ avilable: Bool)
}

protocol ConfirmationViewOutput: ViewOutput {
    var localizeService: StringServiceInterface! { get }
    var windowService: WindowServiceInterface! { get }
    
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    
    func textFieldValueChanged(newValue: String)
    func addToText(_ text: String)
    func removeAtEnd()
    func acceptButtonDidPressed()
    func cancelButtonDidPressed()
}

protocol ConfirmationModuleOutput: ModuleOutput {
    func confirmWithMessage(_ msg: String)
    func cancelWithoutMessage()
}
