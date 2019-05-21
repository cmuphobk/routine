import UIKit

class ConfirmationModulePresenter {
    weak var view: ConfirmationViewInput!
    weak var moduleOutput: ConfirmationModuleOutput?
    
    var localizeService: StringServiceInterface!
    
    var caption: String
    var text: String
    var textFieldValue: String
    var textFieldPlaceholder: String
    var acceptButtonText: String
    var cancelButtonText: String
    
    var windowService: WindowServiceInterface!
    
    init(caption: String,
         text: String,
         textFieldValue: String,
         textFieldPlaceholder: String,
         acceptButtonText: String,
         cancelButtonText: String,
         localizeService: StringServiceInterface,
         windowService: WindowServiceInterface) {
        
        self.caption = caption
        self.text = text
        self.textFieldValue = textFieldValue
        self.textFieldPlaceholder = textFieldPlaceholder
        self.acceptButtonText = acceptButtonText
        self.cancelButtonText = cancelButtonText
        self.localizeService = localizeService
        self.windowService = windowService

    }
}

// MARK: - ConfirmationModuleOutput
extension ConfirmationModulePresenter: ConfirmationViewOutput {
    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
    }
    
    func didTriggerViewWillAppear() {
        // Цепляем локализацию, если что вдруг
        self.view?.updateCaptionText(self.localizeService.localizeId(self.caption))
        self.view?.updateText(self.localizeService.localizeId(self.text))
        self.view?.updateTextFieldValue(self.localizeService.localizeId(self.textFieldValue),
                                        placeholder: self.localizeService.localizeId(self.textFieldPlaceholder))
        self.view?.updateAcceptButtonText(self.localizeService.localizeId(self.acceptButtonText))
        self.view?.updateCancelButtonText(self.localizeService.localizeId(self.cancelButtonText))
        
        self.textFieldValueChanged(newValue: self.textFieldValue)
    }
    
    func textFieldValueChanged(newValue: String) {
        self.textFieldValue = newValue
        self.view?.updateAcceptButtonAvilable( !self.textFieldValue.isEmpty )
    }
    
    func addToText(_ text: String) {
        self.textFieldValue.append(text)
        self.view?.updateTextFieldValue(self.textFieldValue,
                                        placeholder: self.localizeService.localizeId(self.textFieldPlaceholder))
        self.textFieldValueChanged(newValue: self.textFieldValue)
    }
    
    func removeAtEnd() {
        self.textFieldValue = String( self.textFieldValue.dropLast() )
        self.view?.updateTextFieldValue(self.textFieldValue,
                                        placeholder: self.localizeService.localizeId(self.textFieldPlaceholder))
        self.textFieldValueChanged(newValue: self.textFieldValue)
    }
    
    func acceptButtonDidPressed() {
        self.moduleOutput?.confirmWithMessage(self.textFieldValue)
    }
    
    func cancelButtonDidPressed() {
        self.moduleOutput?.cancelWithoutMessage()
    }
}
