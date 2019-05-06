import UIKit
import Stevia

class SectionView: RoutineView<SectionViewModel> {
    
    weak var sectionImageView: RoutineImageView<RoutineImageViewModel>!
    weak var sectionHeaderLabel: RoutineLabel<RoutineLabelViewModel>!
    weak var sectionDescriptionLabel: RoutineLabel<RoutineLabelViewModel>!
    weak var sectionArrowImageView: RoutineImageView<RoutineImageViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let sectionImageView = RoutineImageView()
        let sectionHeaderLabel = RoutineLabel()
        let sectionDescriptionLabel = RoutineLabel()
        let sectionArrowImageView = RoutineImageView()
        
        self.paddingView.sv(
            sectionImageView,
            sectionHeaderLabel,
            sectionDescriptionLabel,
            sectionArrowImageView
        )
        
        self.sectionImageView = sectionImageView
        self.sectionHeaderLabel = sectionHeaderLabel
        self.sectionDescriptionLabel = sectionDescriptionLabel
        self.sectionArrowImageView = sectionArrowImageView
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.sectionImageView.height(self.viewModel.imageHeight)
        self.sectionImageView.Width == self.sectionImageView.Height
        
        layout(
            0.0,
            |self.sectionImageView
        )
        
        self.sectionImageView-self.viewModel.betweenImageOffset-self.sectionHeaderLabel
        
        layout(
            0.0,
            self.sectionHeaderLabel,
            self.viewModel.betweenLabelOffset,
            self.sectionDescriptionLabel,
            >=0.0
        )
        
        align(lefts: self.sectionHeaderLabel, self.sectionDescriptionLabel)
        
        self.sectionArrowImageView.width(self.viewModel.arrowWidth)
        self.sectionArrowImageView.height(self.viewModel.arrowHeight)
        
        self.sectionArrowImageView.centerVertically()
        
        self.sectionHeaderLabel-self.viewModel.betweenArrowOffset-self.sectionArrowImageView|
        self.sectionDescriptionLabel-self.viewModel.betweenArrowOffset-self.sectionArrowImageView|
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.sectionImageView.configureView(config: self.viewModel.sectionImageViewModel)
        self.sectionHeaderLabel.configureView(config: self.viewModel.sectionHeaderLabelModel)
        self.sectionDescriptionLabel.configureView(config: self.viewModel.sectionDescriptionLabelModel)
        self.sectionArrowImageView.configureView(config: self.viewModel.sectionArrowImageViewModel)
    }
    
}
