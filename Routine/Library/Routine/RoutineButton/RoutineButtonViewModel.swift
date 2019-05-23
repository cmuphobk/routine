import UIKit

class RoutineButtonViewModel: RoutineViewModel {
    
    var text: String       = ""
    var textColor: UIColor = UIColor.black
    var font: UIFont       = UIFont.systemFont(ofSize: 12.00)
    var height: CGFloat    = 42.0
    var tintColor: UIColor = UIColor.white
    
    var borderColor: UIColor            = UIColor.white
    var borderWidth: CGFloat            = 0.0
    let contentMode: UIView.ContentMode = .scaleAspectFill
    var image: UIImage?
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.height
    }
    
}
