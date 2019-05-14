import UIKit
import Stevia

class SectionDescriptionView: RoutineView<SectionDescriptionViewModel> {
    
    weak var descriptionLabel: RoutineLabel<RoutineLabelViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let descriptionLabel = RoutineLabel()
        
        self.sv(
            descriptionLabel
        )
        
        self.descriptionLabel = descriptionLabel
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.layout(
            self.viewModel.paddingOffsets.top,
            |-self.viewModel.paddingOffsets.left-self.descriptionLabel-self.viewModel.paddingOffsets.right-|,
            self.viewModel.paddingOffsets.bottom
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.descriptionLabel.configureView(config: self.viewModel.descriptionLabelViewModel)
    }
    
}
