import UIKit

protocol SectionCellViewModelDelegate: class {
    
    func needUpdate(viewModel: SectionCellViewModel)
    
}

final class SectionCellViewModel: RoutineTableViewCellViewModel {
    
    var sectionHeaderViewModel = SectionHeaderViewModel()
    var sectionViewModel = SectionViewModel()
    var sectionDescriptionViewModel = SectionDescriptionViewModel()
    
    weak var delegate: SectionCellViewModelDelegate?
    
    override var reuseIdentifier: String {
        return "SectionCell"
    }
    
    override var cellOwner: CellOwner {
        return .type(value: SectionCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let height = self.sectionDescriptionViewModel.heightForWidth(width - self.leftAndRightPadding)
        let heightSectionView = self.sectionViewModel.heightForWidth(width - self.leftAndRightPadding)
        let heightHeaderView = self.sectionHeaderViewModel.heightForWidth(width - self.leftAndRightPadding)
        let heightRet = self.isExpand ? (heightHeaderView + height + heightSectionView) : heightHeaderView + heightSectionView
        return heightRet + self.topAndBottomPadding
    }

}

// MARK: - SectionHeaderViewModelDelegate
extension SectionCellViewModel: SectionHeaderViewModelDelegate {
    
    func didTriggerCloseButton(viewModel: SectionHeaderViewModel) {
        
        self.isExpand = !self.isExpand
        self.sectionHeaderViewModel.closeButtonViewModel.image = self.isExpand ? ImageProvider.mainModuleImages.whiteCloseIcon : ImageProvider.mainModuleImages.questionIcon
        
        self.delegate?.needUpdate(viewModel: self)
        
    }
    
}
