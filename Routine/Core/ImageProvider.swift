import UIKit

protocol ImageTheme {
    var menuIcon: UIImage { get }
    var backArrow: UIImage { get }
    var warnIcon: UIImage { get }
}

enum ImageProvider {
    static var `default`: ImageTheme = DefaultImages()
}

// MARK: - DefaultTheme
struct DefaultImages: ImageTheme {
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
