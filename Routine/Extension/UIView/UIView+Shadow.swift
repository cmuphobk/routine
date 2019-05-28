import UIKit

extension UIView {

    func aroundShadow() {
        self.aroundShadow(cornerRadius: 8.0, shadowRadius: 8.0)
    }

    func aroundShadow(cornerRadius: CGFloat, shadowRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.65
    }

}
