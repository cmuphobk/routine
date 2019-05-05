import UIKit

class StandartOffsetLabel: UILabel {
    
    var edgeInsets: UIEdgeInsets = .zero {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
        }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.edgeInsets))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: self.edgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -self.edgeInsets.top,
                                          left: -self.edgeInsets.left,
                                          bottom: -self.edgeInsets.bottom,
                                          right: -self.edgeInsets.right)
        
        return textRect.inset(by: invertedInsets)
    }
    
}
