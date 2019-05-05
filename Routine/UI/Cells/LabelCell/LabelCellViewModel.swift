import UIKit

final class LabelCellViewModel: LocalizedTableViewCellViewModel {
    var labelConfiguration: LocalizedLabelViewModel = LocalizedLabelViewModel()
    
    override var reuseIdentifier: String {
        return "LabelCell"
    }
    
    override var cellOwner: CellOwner {
        return .type(value: LabelCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let labelSize = self.labelConfiguration.font.sizeOfString(string: AppDelegate.serviceProvider.makeStringService().localizeById(self.labelConfiguration.text), constrainedToWidth: Double(width - self.labelConfiguration.leftAndRightPadding) )
        return self.topAndBottomPadding + labelSize.height
    }
    
}
