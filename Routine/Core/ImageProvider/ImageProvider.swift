import UIKit

protocol Theme {
    var menuIcon: UIImage { get }
    var backArrow: UIImage { get }
    var warnIcon: UIImage { get }
}

final class ImageProvider {
    static var theme: Theme = DefaultTheme()
}

// MARK: - DefaultTheme
struct DefaultTheme: Theme {
    var menuIcon: UIImage {
        return R.image.menu_icon()!
    }
    var backArrow: UIImage {
        return R.image.back_arrow()!
    }
    var warnIcon: UIImage {
        return R.image.warn_icon()!
    }
}
