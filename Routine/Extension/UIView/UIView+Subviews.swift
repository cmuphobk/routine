
import UIKit

extension UIView {
    
    func getSubviewsTree() -> [UIView] {
        return self.subviews.flatMap { subView -> [UIView] in
            var result = [subView]
            result.append(contentsOf: subView.getSubviewsTree())
            return result
        }
    }
}
