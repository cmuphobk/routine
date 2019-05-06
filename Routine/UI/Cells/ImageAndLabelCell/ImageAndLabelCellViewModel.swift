import UIKit

final class ImageAndLabelCellViewModel: RoutineTableViewCellViewModel {
    
    var image: RoutineImageViewModel = RoutineImageViewModel()
    var label: RoutineLabelViewModel = RoutineLabelViewModel()
    var betweenSpace: CGFloat = 8.0
    
    override var reuseIdentifier: String {
        return "ImageAndLabelCell"
    }
    
    override var cellOwner: CellOwner {
        return .type(value: ImageAndLabelCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let viewHeight = max(self.image.height, self.label.font.sizeOfString(string: AppDelegate.serviceProvider.makeStringService().localizeById(self.label.text), constrainedToWidth: Double(width - self.leftAndRightPadding - self.image.width - self.betweenSpace)).height)
        return viewHeight + self.topAndBottomPadding
    }
    
}
