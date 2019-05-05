import UIKit

class LocalizedTextFieldViewModel: LocalizedViewModel {
    
    var text: String                         = ""
    var textColor: UIColor                   = UIColor.black
    var font: UIFont                         = UIFont.systemFont(ofSize: 12.00)
    var placeholderText: String              = ""
    var keyboardType: UIKeyboardType         = UIKeyboardType.default
    var returnKeyType: UIReturnKeyType       = .done
    var borderStyle: UITextField.BorderStyle = .none
    var height: CGFloat                      = 42.0
    
}
