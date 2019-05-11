import UIKit

extension UIViewController {
    
    // MARK: - Extension stored properties
    
    fileprivate struct CustomProperties {
        static var leftSwipeGestureRecognizer = "leftSwipeGestureRecognizer"
        static var rightSwipeGestureRecognizer = "rightSwipeGestureRecognizer"
    }
    
    fileprivate var leftSwipeGestureRecognizer: UISwipeGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &CustomProperties.leftSwipeGestureRecognizer) as? UISwipeGestureRecognizer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &CustomProperties.leftSwipeGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    fileprivate var rightSwipeGestureRecognizer: UISwipeGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &CustomProperties.rightSwipeGestureRecognizer) as? UISwipeGestureRecognizer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &CustomProperties.rightSwipeGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Methods
    
    func addRightSwipe(action: Selector) {
        self.rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: action)
        self.rightSwipeGestureRecognizer?.direction = UISwipeGestureRecognizer.Direction.right
        
        if let rightSwipeGestureRecognizer = self.rightSwipeGestureRecognizer {
            self.view.addGestureRecognizer(rightSwipeGestureRecognizer)
        }
    }
    
    func addLeftSwipe(action: Selector) {
        self.leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: action)
        self.leftSwipeGestureRecognizer?.direction = UISwipeGestureRecognizer.Direction.left
        
        if let leftSwipeGestureRecognizer = self.leftSwipeGestureRecognizer {
            self.view.addGestureRecognizer(leftSwipeGestureRecognizer)
        }
    }
    
    func deleteRightSwipes() {
        if let rightSwipeGestureRecognizer = self.rightSwipeGestureRecognizer {
            self.view.removeGestureRecognizer(rightSwipeGestureRecognizer)
        }
    }
    
    func leftRightSwipes() {
        if let leftSwipeGestureRecognizer = self.leftSwipeGestureRecognizer {
            self.view.removeGestureRecognizer(leftSwipeGestureRecognizer)
        }
    }
    
}
