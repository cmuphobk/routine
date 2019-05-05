import UIKit
import Stevia

protocol LocalizedComboboxDelegate: class {
    func comboboxDidPressed(viewModel: LocalizedComboboxViewModel)
}

class LocalizedCombobox: LocalizedView<LocalizedComboboxViewModel>, UITextFieldDelegate {
    
    weak var textField: LocalizedTextField<LocalizedTextFieldViewModel>!
    weak var mark: LocalizedImageView<LocalizedImageViewModel>!
    weak var delegate: LocalizedComboboxDelegate?
    
    override func setupView() {
        super.setupView()
        
        let textField = LocalizedTextField()
        let mark = LocalizedImageView()
        
        self.paddingView.sv(
            textField,
            mark
        )
        
        self.textField = textField
        self.mark = mark
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
            self.viewModel.paddingOffsets.top,
            |-self.viewModel.paddingOffsets.left-self.textField-self.viewModel.paddingOffsets.right-|,
            self.viewModel.paddingOffsets.bottom
        )
        
        let markOffset = self.viewModel.paddingOffsets.right == 0.0 ? 8.0 : self.viewModel.paddingOffsets.right * 2
        layout(
            18.0,
            self.mark-markOffset-|
        )
        
        self.mark.width(8.0)
        self.mark.height(8.0)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textField.configureView(config: self.viewModel.textFieldViewModel)
        self.textField.delegate = self
        
        self.mark.configureView(config: self.viewModel.markViewModel)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.delegate?.comboboxDidPressed(viewModel: self.viewModel)
        return false
    }
    
}
