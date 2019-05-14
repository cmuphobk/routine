import UIKit
import Stevia

final class ImageAndLabelCell: RoutineTableViewCell<ImageAndLabelCellViewModel> {
    weak var icon: RoutineImageView<RoutineImageViewModel>!
    weak var label: RoutineLabel<RoutineLabelViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let icon = RoutineImageView()
        let label = RoutineLabel()
        
        self.paddingView.sv(
            icon,
            label
        )
        
        self.icon = icon
        self.label = label
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.layout(
            0.0,
            |self.icon-self.viewModel.betweenSpace-self.label-|,
            0.0
        )
        
        self.icon.height(24.0)
        self.icon.width(24.0)
        
        self.layout(
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
        self.label.text = self.viewModel.routineDelegate?.localize(self.viewModel.label.text) ?? ""
    }
}
