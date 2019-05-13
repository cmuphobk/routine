import UIKit

final class LabelCellViewModel: RoutineTableViewCellViewModel {
    lazy var labelConfiguration: RoutineLabelViewModel = RoutineLabelViewModel(routineDelegate: self.routineDelegate)
    
    override var reuseIdentifier: String {
        return "LabelCell"
    }
    
    override var cellOwner: RoutineCellOwner {
        return .type(value: LabelCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let labelSize = self.labelConfiguration.font.sizeOfString(string: self.routineDelegate?.localize(self.labelConfiguration.text) ?? "",
                                                                  constrainedToWidth: Double(width - self.labelConfiguration.leftAndRightPadding))
        return self.topAndBottomPadding + labelSize.height
    }
    
}
