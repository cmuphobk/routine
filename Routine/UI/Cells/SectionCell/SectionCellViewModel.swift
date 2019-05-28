import UIKit

protocol SectionCellViewModelDelegate: class {

    func needUpdate(viewModel: SectionCellViewModel)

}

final class SectionCellViewModel: RoutineTableViewCellViewModel {

    lazy var sectionHeaderViewModel = SectionHeaderViewModel(routineDelegate: self.routineDelegate)
    lazy var sectionViewModel = SectionViewModel(routineDelegate: self.routineDelegate)
    lazy var sectionDescriptionViewModel = SectionDescriptionViewModel(routineDelegate: self.routineDelegate)

    lazy var shadowViewModel = RoutineViewModel(routineDelegate: self.routineDelegate)

    weak var delegate: SectionCellViewModelDelegate?

    override var reuseIdentifier: String {
        return "SectionCell"
    }

    override var cellOwner: RoutineCellOwner {
        return .type(value: SectionCell.self)
    }

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let height = self.sectionDescriptionViewModel.heightForWidth(width - self.leftAndRightPadding)
        let heightSectionView = self.sectionViewModel.heightForWidth(width - self.leftAndRightPadding)
        let heightHeaderView = self.sectionHeaderViewModel.heightForWidth(width - self.leftAndRightPadding)
        let heightRet: CGFloat!
        if self.isExpand {
            heightRet = heightHeaderView + height + heightSectionView
        } else {
            heightRet = heightHeaderView + heightSectionView
        }
        return heightRet + self.topAndBottomPadding
    }

}

// MARK: - SectionHeaderViewModelDelegate
extension SectionCellViewModel: SectionHeaderViewModelDelegate {

    func didTriggerCloseButton(viewModel: SectionHeaderViewModel) {

        self.isExpand = !self.isExpand
        if self.isExpand {
            self.sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.whiteCloseIcon
        } else {
            self.sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.questionIcon
        }

        self.delegate?.needUpdate(viewModel: self)

    }

}
