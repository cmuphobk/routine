import Foundation

class DateService: DateServiceInterface {

    var languageService: LanguageServiceInterface!

    static var shared = DateService()

    private init () {}

    func localizeDateString(date: Date, format: String) -> String {
        return date.format(with: format, locale: Locale(identifier: self.languageService.currentLanguage().code))
    }

}
