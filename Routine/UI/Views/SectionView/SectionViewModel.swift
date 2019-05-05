import UIKit

class SectionViewModel: LocalizedViewModel {
    
    var sectionImageViewModel = LocalizedImageViewModel()
    var sectionHeaderLabelModel = LocalizedLabelViewModel()
    var sectionDescriptionLabelModel = LocalizedLabelViewModel()
    var sectionArrowImageViewModel = LocalizedImageViewModel()
    
    var betweenImageOffset: CGFloat = 16.0
    var betweenLabelOffset: CGFloat = 8.0
    var betweenArrowOffset: CGFloat = 8.0
    
    var imageHeight: CGFloat = 81.0
    var arrowHeight: CGFloat = 17.0
    var arrowWidth: CGFloat = 10.0
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        
        let widthLabel = width - self.imageHeight - self.betweenImageOffset - self.arrowWidth - self.betweenArrowOffset - self.leftAndRightPadding
        
        let sectionHeaderLabelHeight = self.sectionHeaderLabelModel.heightForWidth(widthLabel)
        let sectionDescriptionLabelHeight = self.sectionDescriptionLabelModel.heightForWidth(widthLabel)
        
        let heightCalc = self.topAndBottomPadding + sectionHeaderLabelHeight + sectionDescriptionLabelHeight + self.betweenLabelOffset
        
        return heightCalc < 114.0 ? 114.0 : heightCalc
    }
}
