import UIKit
import Stevia

class SectionCell: RoutineTableViewCell<SectionCellViewModel> {
    
    weak var sectionHeaderView: SectionHeaderView!
    weak var sectionView: SectionView!
    weak var sectionDescriptionView: SectionDescriptionView!
    
    weak var shadowView: RoutineView<RoutineViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let sectionHeaderView = SectionHeaderView()
        let sectionView = SectionView()
        let sectionDescriptionView = SectionDescriptionView()
        
        self.paddingView.sv(
            sectionHeaderView,
            sectionView,
            sectionDescriptionView
        )
        
        self.sectionHeaderView = sectionHeaderView
        self.sectionView = sectionView
        self.sectionDescriptionView = sectionDescriptionView
        
        let shadowView = RoutineView()
        self.contentView.sv(
            shadowView
        )
        self.shadowView = shadowView
        
        self.contentView.bringSubviewToFront(self.paddingView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
            0.0,
            |self.sectionHeaderView|
        )
        
        layout(
            self.sectionHeaderView,
            |self.sectionView|
        )
        
        layout(
            self.sectionView,
            |self.sectionDescriptionView|
        )
        
        layout(
            self.viewModel.paddingOffsets.top + 2.0,
            |-(self.viewModel.paddingOffsets.left + 2.0)-self.shadowView-(self.viewModel.paddingOffsets.right + 2.0)-|,
            self.viewModel.paddingOffsets.bottom + 2.0
        )
    }
    
    override func updateLayout() {
        super.updateLayout()
        
        let sectionHeaderViewHeight = self.viewModel.sectionHeaderViewModel.heightForWidth(self.frame.width - self.viewModel.leftAndRightPadding)
        
        let sectionViewHeight = self.viewModel.sectionViewModel.heightForWidth(self.frame.width - self.viewModel.leftAndRightPadding)
        
        let sectionDescriptionViewHeight = self.viewModel.sectionDescriptionViewModel.heightForWidth(self.frame.width - self.viewModel.leftAndRightPadding)
        
        if let heightConstraint = self.sectionHeaderView.heightConstraint {
            heightConstraint.constant = sectionHeaderViewHeight
        } else {
            self.sectionHeaderView.height(sectionHeaderViewHeight)
        }
        
        if let heightConstraint = self.sectionView.heightConstraint {
            heightConstraint.constant = sectionViewHeight
        } else {
            self.sectionView.height(sectionViewHeight)
        }
        
        if let heightConstraint = self.sectionDescriptionView.heightConstraint {
            heightConstraint.constant = sectionDescriptionViewHeight
        } else {
            self.sectionDescriptionView.height(sectionDescriptionViewHeight)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.shadowView.configureView(config: self.viewModel.shadowViewModel)
        
        self.sectionHeaderView.configureView(config: self.viewModel.sectionHeaderViewModel)
        self.sectionView.configureView(config: self.viewModel.sectionViewModel)
        self.sectionDescriptionView.configureView(config: self.viewModel.sectionDescriptionViewModel)
        
        self.sectionDescriptionView.isHidden = !self.viewModel.isExpand
        
        self.shadowView.aroundShadow(cornerRadius: self.viewModel.paddingViewCornerRadius, shadowRadius: self.viewModel.paddingViewCornerRadius)
        self.shadowView.layer.masksToBounds = false
    }
    
}
