import Foundation

class StringService: StringServiceInterface {

    var windowService: WindowServiceInterface!
    var languageService: LanguageServiceInterface!

    static var shared = StringService()

    private init () {}

    var styleHtmlString: String = ""

    func localizeId(_ text: String) -> String {
        let result = self.localized(string: text)
        return result
    }

    func pluralsLocalizeId(str1: String, str24: String, str5: String, count: Int) -> String {
        let mod = count % 10

        if count >= 5 && count <= 20 {
            return self.localized(string: str5)

        } else if mod == 1 {
            return self.localized(string: str1)

        } else if mod == 2 || mod == 3 || mod == 4 {
            return self.localized(string: str24)

        } else {
            return self.localized(string: str5)
        }
    }

    func localizeHtmlById(_ stringId: String) -> String {
        let result = self.localized(string: stringId)
        return self.styleHtmlString + result
    }

    private func localized(string: String, tableName: String = "Localizable") -> String {
        let bundle: Bundle? = self.languageService.bundle
        let string = NSLocalizedString(string, tableName: tableName, bundle: bundle ?? Bundle.main, value: "\(string)", comment: "")
        return string
    }

}
