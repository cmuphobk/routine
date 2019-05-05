import UIKit
import Stevia

final class ImageAndLabelCell: LocalizedTableViewCell<ImageAndLabelCellViewModel> {
    weak var icon: LocalizedImageView<LocalizedImageViewModel>!
    weak var label: LocalizedLabel<LocalizedLabelViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let icon = LocalizedImageView()
        let label = LocalizedLabel()
        
        self.paddingView.sv(
            icon,
            label
        )
        
        self.icon = icon
        self.label = label
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
            0.0,
            |self.icon-self.viewModel.betweenSpace-self.label-|,
            0.0
        )
        
        self.icon.height(24.0)
        self.icon.width(24.0)
        
        layout(
            0.0,
            self.label,
            0.0
        )
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.icon.configureView(config: self.viewModel.image)
        self.label.configureView(config: self.viewModel.label)
    }
    
    override func localizationSetup() {
        self.label.text = AppDelegate.serviceProvider.makeStringService().localizeById(self.viewModel.label.text)
    }
}
