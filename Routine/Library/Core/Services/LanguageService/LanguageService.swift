import Foundation

// Singlton
final class LanguageService: LanguageServiceInterface {
    static let shared = LanguageService() // Instance

    private init() {}

    private lazy var ruLanguage = Language(code: "ru", subCode: "ru", name: "Русский")
    private lazy var enLanguage = Language(code: "en", subCode: "us", name: "English")

    // языки в приложении
    private lazy var languagesArray = [
        self.ruLanguage,
        self.enLanguage
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
    }

    // получаем текущий язык
    func currentLanguage() -> Language {
        var currentLanguageCode: String? = Locale.current.languageCode
        if currentLanguageCode == nil {
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
        self.setLanguage(languageName: self.enLanguage.code)
        return self.enLanguage
    }
}
