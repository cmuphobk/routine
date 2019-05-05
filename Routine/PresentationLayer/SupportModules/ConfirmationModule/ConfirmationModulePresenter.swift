import UIKit

class ConfirmationModulePresenter {
    weak var view: ConfirmationModuleInput?
    weak var moduleOutput: ConfirmationModuleModuleOutput?
    
    var caption: String
    var text: String
    var textFieldValue: String
    var textFieldPlaceholder: String
    var acceptButtonText: String
    var cancelButtonText: String
    
    init (caption: String, text: String, textFieldValue: String, textFieldPlaceholder: String, acceptButtonText: String, cancelButtonText: String) {
        self.caption = caption
        self.text = text
        self.textFieldValue = textFieldValue
        self.textFieldPlaceholder = textFieldPlaceholder
        self.acceptButtonText = acceptButtonText
        self.cancelButtonText = cancelButtonText
    }
}

// MARK: - ConfirmationModuleOutput
extension ConfirmationModulePresenter: ConfirmationModuleOutput {
    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
    }
    
    func didTriggerViewWillAppear() {
        // Цепляем локализацию, если что вдруг
        self.view?.updateCaptionText( AppDelegate.serviceProvider.makeStringService().localizeById(self.caption) )
        self.view?.updateText( AppDelegate.serviceProvider.makeStringService().localizeById(self.text) )
        self.view?.updateTextFieldValue( AppDelegate.serviceProvider.makeStringService().localizeById(self.textFieldValue), placeholder: AppDelegate.serviceProvider.makeStringService().localizeById(self.textFieldPlaceholder) )
        self.view?.updateAcceptButtonText( AppDelegate.serviceProvider.makeStringService().localizeById(self.acceptButtonText) )
        self.view?.updateCancelButtonText( AppDelegate.serviceProvider.makeStringService().localizeById(self.cancelButtonText) )
        
        self.textFieldValueChanged(newValue: self.textFieldValue)
    }
    
    func textFieldValueChanged(newValue: String) {
        self.textFieldValue = newValue
        self.view?.updateAcceptButtonAvilable( !self.textFieldValue.isEmpty )
    }
    
    func addToText(_ text: String) {
        self.textFieldValue.append(text)
        self.view?.updateTextFieldValue(self.textFieldValue, placeholder: AppDelegate.serviceProvider.makeStringService().localizeById(self.textFieldPlaceholder))
        self.textFieldValueChanged(newValue: self.textFieldValue)
    }
    
    func removeAtEnd() {
        self.textFieldValue = String( self.textFieldValue.dropLast() )
        self.view?.updateTextFieldValue(self.textFieldValue, placeholder: AppDelegate.serviceProvider.makeStringService().localizeById(self.textFieldPlaceholder))
        self.textFieldValueChanged(newValue: self.textFieldValue)
    }
    
    func acceptButtonDidPressed() {
        self.moduleOutput?.confirmWithMessage(self.textFieldValue)
    }
    
    func cancelButtonDidPressed() {
        self.moduleOutput?.cancelWithoutMessage()
    }
}
