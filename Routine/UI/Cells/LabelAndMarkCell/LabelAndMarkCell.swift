import Foundation
import UIKit
import Stevia

final class LabelAndMarkCell: RoutineTableViewCell<LabelAndMarkCellViewModel> {
    let label = RoutineLabel()
    let icon = RoutineImageView()
    
    override func setupView() {
        super.setupView()
        
        self.paddingView.sv(
            self.label,
            self.icon
        )
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
            0.0,
            |-self.label-self.viewModel.betweenSpace-self.icon-|,
            0.0
        )
        
        self.icon.height(self.viewModel.image.height)
        self.icon.width(self.viewModel.image.width)
        
        layout(
            0.0,
            self.icon,
            0.0
        )
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.label.configureView(config: self.viewModel.label)
        self.icon.configureView(config: self.viewModel.image)
        self.icon.isHidden = !self.viewModel.isSelected
    }
    
    override func localizationSetup() {
        self.label.text = AppDelegate.serviceProvider.makeStringService().localizeById(self.viewModel.label.text)
    }
}
