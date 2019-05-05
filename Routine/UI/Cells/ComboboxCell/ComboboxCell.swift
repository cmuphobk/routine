import UIKit
import Stevia

final class ComboboxCell: LocalizedTableViewCell<ComboboxCellViewModel> {
    
    weak var combobox: LocalizedCombobox!
    
    override func setupView() {
        super.setupView()
        
        let combobox = LocalizedCombobox()
        
        self.paddingView.sv(
            combobox
        )
        
        self.combobox = combobox
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
            0,
            |self.combobox|,
            0
        )

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.combobox.configureView(config: self.viewModel.combobox)
        self.combobox.delegate = self
    }
    
    override func localizationSetup() {
        self.combobox.textField.text = AppDelegate.serviceProvider.makeStringService().localizeById( self.viewModel.combobox.textFieldViewModel.text )
        self.combobox.textField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById( self.viewModel.combobox.textFieldViewModel.placeholderText )
    }
}

// MARK: UIComboboxDelegate
extension ComboboxCell: LocalizedComboboxDelegate {
    
    func comboboxDidPressed(viewModel: LocalizedComboboxViewModel) {
        if viewModel == self.combobox.viewModel {
            self.viewModel.delegate?.expand(viewModel: viewModel)
        }
    }
    
}
