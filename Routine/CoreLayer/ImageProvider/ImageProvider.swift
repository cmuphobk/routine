import UIKit

final class ImageProvider {
    static var `default`: DefaultImages = DefaultImages.shared
    static var authImages: AuthImages = AuthImages.shared
    static var profileImages: ProfileImages = ProfileImages.shared
    static var medicineCourseImages: MedicineCourseImages = MedicineCourseImages.shared
    static var drugsListImages: DrugsListImages = DrugsListImages.shared
    static var drugsDetailsImages: DrugsDetailsImages = DrugsDetailsImages.shared
    static var drugEditImages: DrugEditImages = DrugEditImages.shared
    static var mainModuleImages: MainModuleImages = MainModuleImages.shared
}

// MARK: - DefaultImages
class DefaultImages {
    static var shared = DefaultImages()
    private init() { }
    
    var backArrow: UIImage {
        return R.image.back_arrow()!
    }
    var plusIcon: UIImage {
        return R.image.plus_icon()!
    }
    var menuIcon: UIImage {
        return R.image.menu_icon()!
    }
    var warnIcon: UIImage {
        return R.image.warn_icon()!
    }
    var okIcon: UIImage {
        return R.image.ok_icon()!
    }
    var passOkIcon: UIImage {
        return R.image.pass_ok_icon()!
    }
    var passNoIcon: UIImage {
        return R.image.pass_no_icon()!
    }
    var checkboxIcon: UIImage {
        return R.image.checkbox_icon()!
    }
    var checkboxPressedIcon: UIImage {
        return R.image.checkbox_pressed_icon()!
    }
    var editNavIcon: UIImage {
        return R.image.edit_nav_icon()!
    }
    var agreeIcon: UIImage {
        return R.image.agree_icon()!
    }
    var deleteIcon: UIImage {
        return R.image.delete_drug_icon()!
    }
    var triangleToBottom: UIImage {
        return R.image.triangle_to_bottom()!
    }
    var triangleToRight: UIImage {
        return R.image.triangle_to_right()!
    }
    var addTimesIcon: UIImage {
        return R.image.icon_add_times()!
    }
    var markIcon: UIImage {
        return R.image.mark()!
    }
}

// MARK: - AuthImages
class AuthImages {
    static var shared = AuthImages()
    private init() { }

    var logoIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("logo_icon")
    }
    var eyeIcon: UIImage {
        return R.image.eye_icon()!
    }
    var eyeOpenIcon: UIImage {
        return R.image.eye_open_icon()!
    }
}

// MARK: - ProfileImages
class ProfileImages {
    static var shared = ProfileImages()
    private init() { }

    var logoIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("logo_icon")
    }
}

// MARK: - MainModuleImages
class MainModuleImages {
    static var shared = MainModuleImages()
    private init() { }
    
    var whiteCloseIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("white_close_icon")
    }
    var questionIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("question_icon")
    }
    var percentIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("percent_icon")
    }
    var infoIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("info_icon")
    }
    var drugsIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("drugs_icon")
    }
    var arrowIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("arrow_icon")
    }
    var doctorClinicIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("doctor_clinic_icon")
    }
    var monitoringIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("monitoring_icon")
    }
    var archiveIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("archive_icon")
    }
    var notificationIcon: UIImage {
        return AppDelegate.serviceProvider.makeImageService().localizeById("notification_icon")
    }
    
}

// MARK: - MedicineCourseImages
class MedicineCourseImages {
    static var shared = MedicineCourseImages()
    private init() { }
    
    var plusIcon: UIImage {
        return ImageProvider.default.plusIcon
    }
}

// MARK: - DrugsListImages
class DrugsListImages {
    static var shared = DrugsListImages()
    private init() { }
    
    var createDrugIcon: UIImage {
        return ImageProvider.default.plusIcon
    }
}

// MARK: - DrugsDetailsImages
class DrugsDetailsImages {
    static var shared = DrugsDetailsImages()
    private init() { }
    
    var editIcon: UIImage {
        return ImageProvider.default.editNavIcon
    }
}

// MARK: - DrugEditImages
class DrugEditImages {
    static var shared = DrugEditImages()
    private init() { }
    
    var agreeIcon: UIImage {
        return ImageProvider.default.agreeIcon
    }
    var deleteIcon: UIImage {
        return ImageProvider.default.deleteIcon
    }
    var addTimesIcon: UIImage {
        return ImageProvider.default.addTimesIcon
    }
    var periodCheckMarkIcon: UIImage {
        return ImageProvider.default.markIcon
    }
}
