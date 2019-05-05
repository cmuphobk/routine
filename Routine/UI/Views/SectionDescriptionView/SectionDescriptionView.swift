import UIKit
import Stevia

class SectionDescriptionView: LocalizedView<SectionDescriptionViewModel> {
    
    weak var descriptionLabel: LocalizedLabel<LocalizedLabelViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let descriptionLabel = LocalizedLabel()
        
        self.sv(
            descriptionLabel
        )
        
        self.descriptionLabel = descriptionLabel
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
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
