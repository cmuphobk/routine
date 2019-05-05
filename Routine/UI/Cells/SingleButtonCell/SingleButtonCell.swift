import UIKit
import Stevia

final class SingleButtonCell: LocalizedTableViewCell<SingleButtonCellViewModel> {

    weak var button: LocalizedButton<LocalizedButtonViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let button = LocalizedButton()
        
        self.paddingView.sv(
            button
        )
        
        self.button = button
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
            0,
            |self.button|,
            0
        )
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.button.configureView(config: self.viewModel.buttonConfiguration)
        self.button.addTarget(self, action: #selector(buttonDidPressed), for: UIControl.Event.touchUpInside)
    }
    
    override func localizationSetup() {
        self.button.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById(self.viewModel.buttonConfiguration.text), for: .normal)
    }
    
    @IBAction private func buttonDidPressed(_ sender: UIButton) {
        guard let button = sender as? LocalizedButton<LocalizedButtonViewModel> else {
            return
        }
        self.viewModel.delegate?.buttonDidPressed(sender: button)
    }
}
