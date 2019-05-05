import Foundation

// Singlton
final class LanguageService: LanguageServiceInterface {
    
    var storageService: StorageServiceInterface!
    
    static let shared = LanguageService() // Instance
    
    private init() {}
    
    fileprivate let kCurrentLanguage = "CurrentLanguage"
    fileprivate let kDefaultLangCode = "en"
    fileprivate let kDefaultLangSubCode = "us"
    fileprivate let kDefaultLangName = "English"
    
    // языки в приложении
    private let languagesArray = [
        Language(code: "ru", subCode: "ru", name: "Русский"),
        Language(code: "en", subCode: "us", name: "English")
    ]
    
    var bundle: Bundle? // Bundle с текущей локализацией
    
    // MARK: - Methods
    
    // формирование списка наименований языков
    func languagesList() -> [String] {
        var languages: [String] = []
        
        for item in self.languagesArray {
            languages += [item.name]
        }
        
        return languages
    }
    
    // установка языка по его полному наименованию
    func setLanguage(languageName: String?) {
        
        guard let name = languageName else {
            return
        }
        
        var languageCode: String?
        
        // получаем код выбраного языка
        for item in self.languagesArray where item.name == name {
            languageCode = item.code
            break
        }
        
        // меняем язык
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        
        if let wrappedPath = path {
            self.bundle = Bundle(path: wrappedPath)
        } else {
            // Ставим язык по умолчанию
            self.bundle = nil
        }
        
        self.storageService.set(languageCode, forKey: self.kCurrentLanguage)
    }
    
    // получаем текущий язык
    func currentLanguage() -> Language {

        var currentLanguageCode: String? = Locale.current.languageCode
        
        if currentLanguageCode != nil {
            // empty
        } else {
            currentLanguageCode = Locale.current.languageCode
        }
        
        var currentLang: Language!
        
        // ищем язык по коду
        for item in self.languagesArray where item.code == currentLanguageCode {
            currentLang = Language(code: item.code, subCode: item.subCode, name: item.name)
            break
        }
        
        // если языка не нашлось - ставим английский
        guard currentLang != nil else {
            return self.resetLanguage()
        }
        
        return currentLang
    }

    func resetLanguage() -> Language {
        self.setLanguage(languageName: self.kDefaultLangName)
        return Language(code: self.kDefaultLangCode, subCode: self.kDefaultLangSubCode, name: kDefaultLangName)
    }
}
