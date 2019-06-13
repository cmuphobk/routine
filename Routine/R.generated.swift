//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try font.validate()
    try intern.validate()
  }
  
  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")
    
    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 3 fonts.
  struct font: Rswift.Validatable {
    /// Font `Foros-Bold`.
    static let forosBold = Rswift.FontResource(fontName: "Foros-Bold")
    /// Font `Foros-Medium`.
    static let forosMedium = Rswift.FontResource(fontName: "Foros-Medium")
    /// Font `Foros-Regular`.
    static let forosRegular = Rswift.FontResource(fontName: "Foros-Regular")
    
    /// `UIFont(name: "Foros-Bold", size: ...)`
    static func forosBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: forosBold, size: size)
    }
    
    /// `UIFont(name: "Foros-Medium", size: ...)`
    static func forosMedium(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: forosMedium, size: size)
    }
    
    /// `UIFont(name: "Foros-Regular", size: ...)`
    static func forosRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: forosRegular, size: size)
    }
    
    static func validate() throws {
      if R.font.forosBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Foros-Bold' could not be loaded, is 'Foros-Bold.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.forosMedium(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Foros-Medium' could not be loaded, is 'Foros-Medium.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.forosRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Foros-Regular' could not be loaded, is 'Foros-Regular.otf' added to the UIAppFonts array in this targets Info.plist?") }
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `agree_icon`.
    static let agree_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "agree_icon")
    /// Image `back_arrow`.
    static let back_arrow = Rswift.ImageResource(bundle: R.hostingBundle, name: "back_arrow")
    /// Image `menu_icon`.
    static let menu_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "menu_icon")
    /// Image `warn_icon`.
    static let warn_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "warn_icon")
    
    /// `UIImage(named: "agree_icon", bundle: ..., traitCollection: ...)`
    static func agree_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.agree_icon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "back_arrow", bundle: ..., traitCollection: ...)`
    static func back_arrow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.back_arrow, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "menu_icon", bundle: ..., traitCollection: ...)`
    static func menu_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.menu_icon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "warn_icon", bundle: ..., traitCollection: ...)`
    static func warn_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.warn_icon, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 3 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    /// Storyboard `MenuViewController`.
    static let menuViewController = _R.storyboard.menuViewController()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    /// `UIStoryboard(name: "MenuViewController", bundle: ...)`
    static func menuViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.menuViewController)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 33 localization keys.
    struct localizable {
      /// en translation: count_days
      /// 
      /// Locales: en, ru
      static let count_days = Rswift.StringResource(key: "count_days", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: count_usage_days
      /// 
      /// Locales: en, ru
      static let count_usage_days = Rswift.StringResource(key: "count_usage_days", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: count_usage_number
      /// 
      /// Locales: en, ru
      static let count_usage_number = Rswift.StringResource(key: "count_usage_number", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: days2_4
      /// 
      /// Locales: en, ru
      static let days2_4 = Rswift.StringResource(key: "days2_4", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: days5
      /// 
      /// Locales: en, ru
      static let days5 = Rswift.StringResource(key: "days5", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: days_1
      /// 
      /// Locales: en, ru
      static let days_1 = Rswift.StringResource(key: "days_1", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: end_usage_date
      /// 
      /// Locales: en, ru
      static let end_usage_date = Rswift.StringResource(key: "end_usage_date", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: end_usage_date_to
      /// 
      /// Locales: en, ru
      static let end_usage_date_to = Rswift.StringResource(key: "end_usage_date_to", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: usage_1
      /// 
      /// Locales: en, ru
      static let usage_1 = Rswift.StringResource(key: "usage_1", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: usage_2_4
      /// 
      /// Locales: en, ru
      static let usage_2_4 = Rswift.StringResource(key: "usage_2_4", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: usage_5
      /// 
      /// Locales: en, ru
      static let usage_5 = Rswift.StringResource(key: "usage_5", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: week_days
      /// 
      /// Locales: en, ru
      static let week_days = Rswift.StringResource(key: "week_days", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Воскресенье
      /// 
      /// Locales: en, ru
      static let full_sunday = Rswift.StringResource(key: "full_sunday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Вс
      /// 
      /// Locales: en, ru
      static let short_sunday = Rswift.StringResource(key: "short_sunday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Вт
      /// 
      /// Locales: en, ru
      static let short_tuesday = Rswift.StringResource(key: "short_tuesday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Вторник
      /// 
      /// Locales: en, ru
      static let full_tuesday = Rswift.StringResource(key: "full_tuesday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Каждый день
      /// 
      /// Locales: en, ru
      static let full_allday = Rswift.StringResource(key: "full_allday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Меню
      /// 
      /// Locales: en, ru
      static let menu_alias = Rswift.StringResource(key: "menu_alias", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Меню
      /// 
      /// Locales: en, ru
      static let menu_name = Rswift.StringResource(key: "menu_name", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Ошибка соединения!
      /// 
      /// Locales: en, ru
      static let error_network = Rswift.StringResource(key: "error_network", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Пн
      /// 
      /// Locales: en, ru
      static let short_monday = Rswift.StringResource(key: "short_monday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Понедельник
      /// 
      /// Locales: en, ru
      static let full_monday = Rswift.StringResource(key: "full_monday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Пт
      /// 
      /// Locales: en, ru
      static let short_friday = Rswift.StringResource(key: "short_friday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Пятница
      /// 
      /// Locales: en, ru
      static let full_friday = Rswift.StringResource(key: "full_friday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Рабочий стол
      /// 
      /// Locales: en, ru
      static let main_alias = Rswift.StringResource(key: "main_alias", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Рабочий стол
      /// 
      /// Locales: en, ru
      static let main_name = Rswift.StringResource(key: "main_name", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Рутина
      /// 
      /// Locales: en, ru
      static let logo_string = Rswift.StringResource(key: "logo_string", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Сб
      /// 
      /// Locales: en, ru
      static let short_saturday = Rswift.StringResource(key: "short_saturday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Ср
      /// 
      /// Locales: en, ru
      static let short_wednesday = Rswift.StringResource(key: "short_wednesday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Среда
      /// 
      /// Locales: en, ru
      static let full_wednesday = Rswift.StringResource(key: "full_wednesday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Суббота
      /// 
      /// Locales: en, ru
      static let full_saturday = Rswift.StringResource(key: "full_saturday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Четверг
      /// 
      /// Locales: en, ru
      static let full_thursday = Rswift.StringResource(key: "full_thursday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      /// en translation: Чт
      /// 
      /// Locales: en, ru
      static let short_thursday = Rswift.StringResource(key: "short_thursday", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "ru"], comment: nil)
      
      /// en translation: count_days
      /// 
      /// Locales: en, ru
      static func count_days(_: Void = ()) -> String {
        return NSLocalizedString("count_days", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: count_usage_days
      /// 
      /// Locales: en, ru
      static func count_usage_days(_: Void = ()) -> String {
        return NSLocalizedString("count_usage_days", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: count_usage_number
      /// 
      /// Locales: en, ru
      static func count_usage_number(_: Void = ()) -> String {
        return NSLocalizedString("count_usage_number", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: days2_4
      /// 
      /// Locales: en, ru
      static func days2_4(_: Void = ()) -> String {
        return NSLocalizedString("days2_4", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: days5
      /// 
      /// Locales: en, ru
      static func days5(_: Void = ()) -> String {
        return NSLocalizedString("days5", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: days_1
      /// 
      /// Locales: en, ru
      static func days_1(_: Void = ()) -> String {
        return NSLocalizedString("days_1", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: end_usage_date
      /// 
      /// Locales: en, ru
      static func end_usage_date(_: Void = ()) -> String {
        return NSLocalizedString("end_usage_date", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: end_usage_date_to
      /// 
      /// Locales: en, ru
      static func end_usage_date_to(_: Void = ()) -> String {
        return NSLocalizedString("end_usage_date_to", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: usage_1
      /// 
      /// Locales: en, ru
      static func usage_1(_: Void = ()) -> String {
        return NSLocalizedString("usage_1", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: usage_2_4
      /// 
      /// Locales: en, ru
      static func usage_2_4(_: Void = ()) -> String {
        return NSLocalizedString("usage_2_4", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: usage_5
      /// 
      /// Locales: en, ru
      static func usage_5(_: Void = ()) -> String {
        return NSLocalizedString("usage_5", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: week_days
      /// 
      /// Locales: en, ru
      static func week_days(_: Void = ()) -> String {
        return NSLocalizedString("week_days", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Воскресенье
      /// 
      /// Locales: en, ru
      static func full_sunday(_: Void = ()) -> String {
        return NSLocalizedString("full_sunday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Вс
      /// 
      /// Locales: en, ru
      static func short_sunday(_: Void = ()) -> String {
        return NSLocalizedString("short_sunday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Вт
      /// 
      /// Locales: en, ru
      static func short_tuesday(_: Void = ()) -> String {
        return NSLocalizedString("short_tuesday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Вторник
      /// 
      /// Locales: en, ru
      static func full_tuesday(_: Void = ()) -> String {
        return NSLocalizedString("full_tuesday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Каждый день
      /// 
      /// Locales: en, ru
      static func full_allday(_: Void = ()) -> String {
        return NSLocalizedString("full_allday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Меню
      /// 
      /// Locales: en, ru
      static func menu_alias(_: Void = ()) -> String {
        return NSLocalizedString("menu_alias", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Меню
      /// 
      /// Locales: en, ru
      static func menu_name(_: Void = ()) -> String {
        return NSLocalizedString("menu_name", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Ошибка соединения!
      /// 
      /// Locales: en, ru
      static func error_network(_: Void = ()) -> String {
        return NSLocalizedString("error_network", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Пн
      /// 
      /// Locales: en, ru
      static func short_monday(_: Void = ()) -> String {
        return NSLocalizedString("short_monday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Понедельник
      /// 
      /// Locales: en, ru
      static func full_monday(_: Void = ()) -> String {
        return NSLocalizedString("full_monday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Пт
      /// 
      /// Locales: en, ru
      static func short_friday(_: Void = ()) -> String {
        return NSLocalizedString("short_friday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Пятница
      /// 
      /// Locales: en, ru
      static func full_friday(_: Void = ()) -> String {
        return NSLocalizedString("full_friday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Рабочий стол
      /// 
      /// Locales: en, ru
      static func main_alias(_: Void = ()) -> String {
        return NSLocalizedString("main_alias", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Рабочий стол
      /// 
      /// Locales: en, ru
      static func main_name(_: Void = ()) -> String {
        return NSLocalizedString("main_name", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Рутина
      /// 
      /// Locales: en, ru
      static func logo_string(_: Void = ()) -> String {
        return NSLocalizedString("logo_string", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Сб
      /// 
      /// Locales: en, ru
      static func short_saturday(_: Void = ()) -> String {
        return NSLocalizedString("short_saturday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Ср
      /// 
      /// Locales: en, ru
      static func short_wednesday(_: Void = ()) -> String {
        return NSLocalizedString("short_wednesday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Среда
      /// 
      /// Locales: en, ru
      static func full_wednesday(_: Void = ()) -> String {
        return NSLocalizedString("full_wednesday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Суббота
      /// 
      /// Locales: en, ru
      static func full_saturday(_: Void = ()) -> String {
        return NSLocalizedString("full_saturday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Четверг
      /// 
      /// Locales: en, ru
      static func full_thursday(_: Void = ()) -> String {
        return NSLocalizedString("full_thursday", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Чт
      /// 
      /// Locales: en, ru
      static func short_thursday(_: Void = ()) -> String {
        return NSLocalizedString("short_thursday", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try main.validate()
      try menuViewController.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'logo' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let mainViewController = StoryboardViewControllerResource<MainViewController>(identifier: "MainViewController")
      let name = "Main"
      
      func mainViewController(_: Void = ()) -> MainViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: mainViewController)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.main().mainViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'mainViewController' could not be loaded from storyboard 'Main' as 'MainViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct menuViewController: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let menuViewController = StoryboardViewControllerResource<MenuViewController>(identifier: "MenuViewController")
      let name = "MenuViewController"
      
      func menuViewController(_: Void = ()) -> MenuViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: menuViewController)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.menuViewController().menuViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'menuViewController' could not be loaded from storyboard 'MenuViewController' as 'MenuViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
