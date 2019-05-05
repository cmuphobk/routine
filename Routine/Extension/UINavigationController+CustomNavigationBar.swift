import UIKit

extension UINavigationController {
    
    func configureTransparentNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.barTintColor = ColorProvider.default.clearColor
    }
    
    func configureNavigationBarWithColor(_ color: UIColor) {
        self.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationBar.shadowImage = nil
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = color
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorProvider.default.whiteColor]
    }
    
}
