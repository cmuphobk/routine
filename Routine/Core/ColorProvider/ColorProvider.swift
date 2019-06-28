import UIKit

final class ColorProvider {
    static var `default`: DefaultColors = DefaultColors.shared
    static var messageColors: MessageColors = MessageColors.shared
    static var mainModuleColors: MainModuleColors = MainModuleColors.shared
    static var menuColors: MenuColors = MenuColors.shared
}

// MARK: - DefaultColor
class DefaultColors {
    static var shared = DefaultColors()
    private init() { }

    var clearColor: UIColor {
        return UIColor.clear
    }
    var whiteColor: UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    var whiteTransparentColor: UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8)
    }
    var blackColor: UIColor {
        return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    var lightBlackColor: UIColor {
        return UIColor(red: 0.23, green: 0.25, blue: 0.26, alpha: 1)
    }
    var blueColor: UIColor {
        return UIColor(red: 0.00, green: 0.59, blue: 0.78, alpha: 1)
    }
    var lightBlueColor: UIColor {
        return UIColor(red: 0.22, green: 0.72, blue: 0.88, alpha: 1)
    }
    var lightGrayColor: UIColor {
        return  UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1)
    }
    var lighterGrayColor: UIColor {
        return  UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    }
    var grayColor: UIColor {
        return UIColor(red: 0.52, green: 0.52, blue: 0.52, alpha: 1)
    }
    var backgroundWhiteColor: UIColor {
        return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }
    var lightRedColor: UIColor {
        return UIColor(red: 0.94, green: 0.34, blue: 0.34, alpha: 1)
    }
    var greenColor: UIColor {
        return UIColor(red: 0.39, green: 0.82, blue: 0.51, alpha: 1)
    }

}

// MARK: - MenuColors
class MenuColors {
    static var shared = MenuColors()
    private init() { }

    var menuCellBackgroundColor: UIColor {
        return ColorProvider.default.blueColor
    }
}

// MARK: - MessageColors
class MessageColors {
    static var shared = MessageColors()
    private init() { }

    var backgroundRedColor: UIColor {
        return UIColor(red: 0.94, green: 0.34, blue: 0.34, alpha: 1)
    }
    var backgroundGreenColor: UIColor {
        return UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0)
    }
    var backgroundYellowColor: UIColor {
        return UIColor(red: 225.0/255.0, green: 222.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
}

// MARK: - MainModuleColors
class MainModuleColors {
    static var shared = MainModuleColors()
    private init() { }

    var whiteColor: UIColor {
        return ColorProvider.default.whiteColor
    }
    var blueColor: UIColor {
        return ColorProvider.default.blueColor
    }
    var blueViewColor: UIColor {
        return ColorProvider.default.lightBlueColor
    }
    var blackTextColor: UIColor {
        return ColorProvider.default.blackColor
    }
    var greenColor: UIColor {
        return ColorProvider.default.greenColor
    }
    var backgroundWhiteColor: UIColor {
        return ColorProvider.default.backgroundWhiteColor
    }
}
