import UIKit

class SectionDescriptionViewModel: RoutineViewModel {
    
    lazy var descriptionLabelViewModel = RoutineLabelViewModel(routineDelegate: self.routineDelegate)
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let heightLabel = self.descriptionLabelViewModel.heightForWidth(width - self.leftAndRightPadding )
        return heightLabel + self.topAndBottomPadding
    }
    
}
