import UIKit

class RoutineTextViewModel: RoutineViewModel {

    var text: String                         = ""
    var textColor: UIColor                   = UIColor.black
    var font: UIFont                         = UIFont.systemFont(ofSize: 12.00)
    var placeholderText: String              = ""
    var returnKeyType: UIReturnKeyType       = .done
    var height: CGFloat                      = 42.0

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.height
    }
}
