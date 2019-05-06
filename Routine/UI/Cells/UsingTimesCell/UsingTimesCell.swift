import UIKit
import Stevia

final class UsingTimesCell: RoutineTableViewCell<UsingTimesCellViewModel>, UITextFieldDelegate {
    
    weak var numberLabel: RoutineLabel<RoutineLabelViewModel>!
    weak var timesBox: RoutineCombobox!
    weak var countField: RoutineTextField<RoutineTextFieldViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let numberLabel = RoutineLabel()
        let timesBox = RoutineCombobox()
        let countField = RoutineTextField()
    
        self.paddingView.sv(
            numberLabel,
            timesBox,
            countField
        )
        
        self.numberLabel = numberLabel
        self.timesBox = timesBox
        self.countField = countField
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
            0.0,
            |self.numberLabel-8.0-self.timesBox-16.0-self.countField|,
            0.0
        )
        
        layout(
            0.0,
            self.timesBox,
            0.0
        )
        
        layout(
            0.0,
            self.countField,
            0.0
        )
        
        self.numberLabel.width(32.0)
        self.timesBox.width(92.0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.numberLabel.configureView(config: self.viewModel.numberLabel)
        self.timesBox.configureView(config: self.viewModel.timesBox)
        self.countField.configureView(config: self.viewModel.countField)
        
        self.timesBox.delegate = self
        
        self.countField.delegate = self
        self.countField.addTarget(self, action: #selector(textFieldChangedAction), for: UIControl.Event.editingChanged)
    }
    
    override func localizationSetup() {
        self.numberLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById( self.viewModel.numberLabel.text )
        self.timesBox.textField.text = AppDelegate.serviceProvider.makeStringService().localizeById( self.viewModel.timesBox.textFieldViewModel.text )
        self.timesBox.textField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById( self.viewModel.timesBox.textFieldViewModel.placeholderText )
        self.countField.text = AppDelegate.serviceProvider.makeStringService().localizeById( self.viewModel.countField.text )
        self.countField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById( self.viewModel.countField.placeholderText )
    }
    
    @objc private func textFieldChangedAction(_ sender: UITextField) {
        self.viewModel.countField.text = sender.text ?? ""
        self.viewModel.delegate?.textChanged(sender: self.viewModel)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.countField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        
        let text = (textField.text ?? "") + string
        let dotCount = text.components(separatedBy: ".").count
        let commaCount = text.components(separatedBy: ",").count
        
        return !(dotCount > 2 || commaCount > 2)
    }
}

extension UsingTimesCell: RoutineComboboxDelegate {
    
    func comboboxDidPressed(viewModel: RoutineComboboxViewModel) {
        self.viewModel.delegate?.timeStartEdited(sender: self.viewModel)
    }
    
}
