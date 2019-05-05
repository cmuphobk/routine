import UIKit

protocol WindowServiceInterface: class {
    
    var screenWidth: CGFloat { get }
    
    var screenHeight: CGFloat { get }
    
    var is5sAndLess: Bool { get }
    
    var userInterfaceIdiom: UIUserInterfaceIdiom { get }
    
}
