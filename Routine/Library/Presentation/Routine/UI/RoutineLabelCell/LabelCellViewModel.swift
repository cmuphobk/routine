import UIKit

final class LabelCellViewModel: RoutineTableViewCellViewModel {
    lazy var labelViewModel: RoutineLabelViewModel = RoutineLabelViewModel()

    override var reuseIdentifier: String {
        return "LabelCell"
    }

    override var cellOwner: RoutineCellOwner {
        return .type(value: LabelCell.self)
    }

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let labelSize = self.labelViewModel.font.sizeOfStringLabel(
            string: self.routineDelegate?.localize(self.labelViewModel.text) ?? "",
            constrainedToWidth: Double(width - self.labelViewModel.leftAndRightPadding))

        return self.topAndBottomPadding + labelSize.height
    }

}
