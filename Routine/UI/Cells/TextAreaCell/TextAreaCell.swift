import UIKit
import Stevia

final class TextAreaCell: LocalizedTableViewCell<TextAreaCellViewModel>, UITextFieldDelegate, UITextViewDelegate {

    weak private var textArea: LocalizedTextView<LocalizedTextViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let textArea = LocalizedTextView()
        
        self.paddingView.sv(
            textArea
        )
        
        self.textArea = textArea
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
            0,
            |self.textArea|,
            0
        )
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textArea.configureView(config: self.viewModel.textAreaConfiguration)
        self.textArea.delegate = self
    }

    override func localizationSetup() {
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.textArea.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.viewModel.delegate?.textChanged(object: self.viewModel.textAreaConfiguration, newValue: textView.text)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.viewModel.delegate?.textBeginEdited(object: self.viewModel.textAreaConfiguration)
    }
    
}
