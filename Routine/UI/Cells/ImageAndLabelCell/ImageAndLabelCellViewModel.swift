import UIKit

final class ImageAndLabelCellViewModel: RoutineTableViewCellViewModel {

    lazy var image: RoutineImageViewModel = RoutineImageViewModel()
    lazy var label: RoutineLabelViewModel = RoutineLabelViewModel()
    var betweenSpace: CGFloat = 8.0

    override var reuseIdentifier: String {
        return "ImageAndLabelCell"
    }

    override var cellOwner: RoutineCellOwner {
        return .type(value: ImageAndLabelCell.self)
    }

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let width = Double(width - self.leftAndRightPadding - self.image.width - self.betweenSpace)
        let text = self.routineDelegate?.localize(self.label.text) ?? ""
        let viewHeight = max(self.image.height,
                             self.label.font.sizeOfStringLabel(string: text,
                                                               constrainedToWidth: width).height)
        return viewHeight + self.topAndBottomPadding
    }

}
