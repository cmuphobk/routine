import UIKit

class SectionDescriptionViewModel: LocalizedViewModel {
    
    var descriptionLabelViewModel = LocalizedLabelViewModel()
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let heightLabel = self.descriptionLabelViewModel.heightForWidth(width - self.leftAndRightPadding )
        return heightLabel + self.topAndBottomPadding
    }
    
}
