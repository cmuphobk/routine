import UIKit

protocol FontTheme {
    var forosRegular14: UIFont { get }
    var forosBold14: UIFont { get }
    var forosMedium14: UIFont { get }
}

enum FontProvider {
    static var `default`: FontTheme = DefaultFonts()
}

// MARK: - DefaultFonts
class DefaultFonts: FontTheme {
    var forosRegular14: UIFont {
        return R.font.forosRegular(size: 14.00)!
    }
    var forosBold14: UIFont {
        return R.font.forosBold(size: 14.00)!
    }
    var forosMedium14: UIFont {
        return R.font.forosMedium(size: 14.00)!
    }
}
