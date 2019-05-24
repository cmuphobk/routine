import UIKit

final class FontProvider {
    static var `default`: DefaultFonts = DefaultFonts.shared
    static var mainModuleFonts: MainModuleFonts = MainModuleFonts.shared
    static var menuFonts: MenuFonts = MenuFonts.shared
}

// MARK: - DefaultFonts
class DefaultFonts {
    static var shared = DefaultFonts()
    private init() { }
    
    var forosRegular11: UIFont {
        return R.font.forosRegular(size: 11.00)!
    }
    var forosRegular12: UIFont {
        return R.font.forosRegular(size: 12.00)!
    }
    var forosRegular13: UIFont {
        return R.font.forosRegular(size: 13.00)!
    }
    var forosRegular14: UIFont {
        return R.font.forosRegular(size: 14.00)!
    }
    var forosRegular16: UIFont {
        return R.font.forosRegular(size: 16.00)!
    }
    var forosRegular17: UIFont {
        return R.font.forosRegular(size: 17.00)!
    }
    var forosBold17: UIFont {
        return R.font.forosBold(size: 17.00)!
    }
    var forosRegular18: UIFont {
        return R.font.forosRegular(size: 18.00)!
    }
    var forosMedium14: UIFont {
        return R.font.forosMedium(size: 14.00)!
    }
    var forosMedium15: UIFont {
        return R.font.forosMedium(size: 15.00)!
    }
    var forosMedium17: UIFont {
        return R.font.forosMedium(size: 17.00)!
    }
    var forosMedium18: UIFont {
        return R.font.forosMedium(size: 18.00)!
    }
    var forosMedium67: UIFont {
        return R.font.forosMedium(size: 67.00)!
    }
    var forosMedium47: UIFont {
        return R.font.forosMedium(size: 47.00)!
    }
    
    var standart: UIFont {
        return UIFont.systemFont(ofSize: 17.00)
    }
    var standartPages: UIFont {
        return UIFont.systemFont(ofSize: 14.00)
    }
    var textFieldButton: UIFont {
        return self.forosRegular16
    }
    var blueButton: UIFont {
        return self.forosRegular18
    }
    var blueSmallButton: UIFont {
        return self.forosRegular16
    }
    var blackButton: UIFont {
        return self.forosRegular16
    }
    var blackSmallButton: UIFont {
        return self.forosRegular13
    }
    var informationMessage: UIFont {
        return self.forosRegular12
    }
}

// MARK: - MainModuleFonts
class MainModuleFonts {
    static var shared = MainModuleFonts()
    private init() { }
    
    var sectionHeaderLabel: UIFont {
        return FontProvider.default.forosMedium14
    }
    var sectionLabel: UIFont {
        return FontProvider.default.forosMedium18
    }
    var sectionDescriptionLabel: UIFont {
        return FontProvider.default.forosRegular14
    }
}

// MARK: - MenuFonts
class MenuFonts {
    static var shared = MenuFonts()
    private init() { }
    
    var menu: UIFont {
        return FontProvider.default.forosRegular17
    }
    var selectedMenu: UIFont {
        return FontProvider.default.forosBold17
    }
}
