import UIKit

class SectionDescriptionViewModel: RoutineViewModel {
    
    var descriptionLabelViewModel = RoutineLabelViewModel()
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let heightLabel = self.descriptionLabelViewModel.heightForWidth(width - self.leftAndRightPadding )
        return heightLabel + self.topAndBottomPadding
    }
    
}
