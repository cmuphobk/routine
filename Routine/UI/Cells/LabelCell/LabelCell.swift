import UIKit
import Stevia

final class LabelCell: LocalizedTableViewCell<LabelCellViewModel> {
    weak private var label: LocalizedLabel<LocalizedLabelViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let label = LocalizedLabel()
        
        self.paddingView.sv(
            label
        )
        
        self.label = label
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
            0,
            |self.label|,
            0
        )
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.label.configureView(config: self.viewModel.labelConfiguration)
    }
    
    override func localizationSetup() {
        self.label.text = AppDelegate.serviceProvider.makeStringService().localizeById(self.viewModel.labelConfiguration.text)
    }

}
