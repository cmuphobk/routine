import UIKit
import Stevia

final class TextFieldCell: LocalizedTableViewCell<TextFieldCellViewModel>, UITextFieldDelegate {

    weak var textField: LocalizedTextField<LocalizedTextFieldViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let textField = LocalizedTextField()
        
        self.paddingView.sv(
            textField
        )
        
        self.textField = textField
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
            0.0,
            |self.textField|,
            0.0
        )
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textField.configureView(config: self.viewModel.textFieldConfiguration)
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(textFieldChangedAction), for: UIControl.Event.editingChanged)
    }
    
    override func localizationSetup() {
        self.textField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById( self.viewModel.textFieldConfiguration.placeholderText )
    }
    
    @objc private func textFieldChangedAction(_ sender: UITextField) {
        self.viewModel.textFieldConfiguration.text = sender.text ?? ""
        self.viewModel.delegate?.textChanged(object: self.viewModel.textFieldConfiguration, newValue: sender.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }

 }
