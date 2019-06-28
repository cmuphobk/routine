import UIKit

extension UIFont {

    func sizeOfStringLabel (string: String, constrainedToWidth width: CGFloat) -> CGSize {
        let attributes = [NSAttributedString.Key.font: self]
        let attString = NSAttributedString(string: string, attributes: attributes)

        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = attString
        return label.sizeThatFits(CGSize(width: width, height: 0))
    }

    func sizeOfStringTextView (string: String, constrainedToWidth width: CGFloat) -> CGSize {
        let attributes = [NSAttributedString.Key.font: self]
        let attString = NSAttributedString(string: string, attributes: attributes)

        let textView = UITextView()
        textView.attributedText = attString
        return textView.sizeThatFits(CGSize(width: width, height: 0))
    }

}
