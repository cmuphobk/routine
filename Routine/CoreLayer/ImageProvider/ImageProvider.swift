import UIKit

final class ImageProvider {
    static var `default`: DefaultImages = DefaultImages.shared
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
