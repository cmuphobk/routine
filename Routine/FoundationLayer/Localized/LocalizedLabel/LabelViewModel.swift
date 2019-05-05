import UIKit

class LocalizedLabelViewModel: LocalizedViewModel {
    
    var text: String = ""
    var textColor: UIColor = UIColor.black
    var font: UIFont  = UIFont.systemFont(ofSize: 12.00)
    var numberOfLines = 1
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let height = self.font.sizeOfString(string: AppDelegate.serviceProvider.makeStringService().localizeById(self.text), constrainedToWidth: Double(width)).height
        return height
    }
}
