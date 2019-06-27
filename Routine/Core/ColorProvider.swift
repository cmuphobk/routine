import UIKit

protocol ColorTheme {
    var clearColor: UIColor { get }
    var whiteColor: UIColor { get }
    var blackColor: UIColor { get }
    var blueColor: UIColor { get }
    var grayColor: UIColor { get }
}

enum ColorProvider {
    static var `default`: ColorTheme = DefaultColors()
}

// MARK: - DefaultColor
class DefaultColors: ColorTheme {
    var clearColor: UIColor {
        return UIColor.clear
    }
    var whiteColor: UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    var blackColor: UIColor {
        return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    var blueColor: UIColor {
        return UIColor(red: 0.00, green: 0.59, blue: 0.78, alpha: 1)
    }
    var grayColor: UIColor {
        return UIColor(red: 0.52, green: 0.52, blue: 0.52, alpha: 1)
    }
}
