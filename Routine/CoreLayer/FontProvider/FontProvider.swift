import UIKit

final class FontProvider {
    static var `default`: DefaultFonts = DefaultFonts.shared
    static var mainModuleFonts: MainModuleFonts = MainModuleFonts.shared
    static var menuFonts: MenuFonts = MenuFonts.shared
    static var pinCodeFonts: PinCodeFonts = PinCodeFonts.shared
    static var registratonFonts: RegistratonFonts = RegistratonFonts.shared
    static var profileFonts: ProfileFonts = ProfileFonts.shared
    static var methodObtainingFonts: MethodObtainingFonts = MethodObtainingFonts.shared
    static var restorePasswordFonts: RestorePasswordFonts = RestorePasswordFonts.shared
    static var errorCodeFonts: ErrorCodeFonts = ErrorCodeFonts.shared
    static var medicineCourseFonts: MedicineCourseFonts = MedicineCourseFonts.shared
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

// MARK: - PinCodeFonts
class PinCodeFonts {
    static var shared = PinCodeFonts()
    private init() { }
    
    var topLabel: UIFont {
        return FontProvider.default.forosMedium17
    }
    var topSmallLabel: UIFont {
        return FontProvider.default.forosMedium15
    }
    var descriptionTopLabel: UIFont {
        return FontProvider.default.forosRegular14
    }
    var descriptionTopSmallLabel: UIFont {
        return FontProvider.default.forosRegular13
    }
    var textField: UIFont {
        return FontProvider.default.forosMedium67
    }
    var textFieldSmall: UIFont {
        return FontProvider.default.forosMedium47
    }
}

// MARK: - RegistratonFonts
class RegistratonFonts {
    static var shared = RegistratonFonts()
    private init() { }
    
    var titleLabel: UIFont {
        return FontProvider.default.forosMedium17
    }
    var descriptionLabel: UIFont {
        return FontProvider.default.forosRegular14
    }
    var agreementLabel: UIFont {
        return FontProvider.default.forosRegular13
    }
    var descriptionSmallLabel: UIFont {
        return FontProvider.default.forosRegular12
    }
    var agreementSmallLabel: UIFont {
        return FontProvider.default.forosRegular11
    }
    var linkLabel: UIFont {
        return FontProvider.default.forosRegular16
    }

}

// MARK: - ProfileFonts
class ProfileFonts {
    static var shared = ProfileFonts()
    private init() { }
    
    var titleLabel: UIFont {
        return FontProvider.default.forosMedium17
    }
    var descriptionLabel: UIFont {
        return FontProvider.default.forosRegular14
    }
    var descriptionSmallLabel: UIFont {
        return FontProvider.default.forosRegular12
    }

}

// MARK: - MethodObtainingFonts
class MethodObtainingFonts {
    static var shared = MethodObtainingFonts()
    private init() { }
    
    var titleLabel: UIFont {
        return FontProvider.default.forosMedium17
    }
    var descriptionLabel: UIFont {
        return FontProvider.default.forosRegular14
    }
}

// MARK: - RestorePasswordFonts
class RestorePasswordFonts {
    static var shared = RestorePasswordFonts()
    private init() { }
    
    var titleLabel: UIFont {
        return FontProvider.default.forosMedium17
    }
    var smallTitleLabel: UIFont {
        return FontProvider.default.forosMedium15
    }
    var descriptionLabel: UIFont {
        return FontProvider.default.forosRegular14
    }
    var descriptionSmallLabel: UIFont {
        return FontProvider.default.forosRegular12
    }
}

// MARK: - ErrorCodeFonts
class ErrorCodeFonts {
    static var shared = ErrorCodeFonts()
    private init() { }
    
    var titleLabel: UIFont {
        return FontProvider.default.forosMedium17
    }
    var smallTitleLabel: UIFont {
        return FontProvider.default.forosMedium15
    }
    var descriptionLabel: UIFont {
        return FontProvider.default.forosRegular14
    }
    var descriptionSmallLabel: UIFont {
        return FontProvider.default.forosRegular12
    }
}

// MARK: - MedicineCourseFonts
class MedicineCourseFonts {
    static var shared = MedicineCourseFonts()
    private init() { }
    
    var general: UIFont {
        return FontProvider.default.forosRegular16
    }
    
    var titleLabel: UIFont {
        return FontProvider.default.forosRegular16
    }
    var drugsList: UIFont {
        return FontProvider.default.forosRegular12
    }
    var dateLabel: UIFont {
        return FontProvider.default.forosRegular12
    }
    
    var drugName: UIFont {
        return FontProvider.default.forosRegular16
    }
    var drugPortion: UIFont {
        return FontProvider.default.forosRegular12
    }
    var drugTimes: UIFont {
        return FontProvider.default.forosRegular12
    }
    
    var buttonFont: UIFont {
        return FontProvider.default.forosRegular16
    }
}
