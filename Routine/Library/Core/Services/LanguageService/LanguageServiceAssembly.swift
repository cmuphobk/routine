import Foundation

enum LanguageServiceAssembly {
    static func build() -> LanguageServiceInterface {
        let languageService = LanguageService()
        return languageService
    }
}
