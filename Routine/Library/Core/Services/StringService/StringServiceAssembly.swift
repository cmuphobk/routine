import Foundation

enum StringServiceAssembly {

    static func build(windowService: WindowServiceInterface,
                      languageService: LanguageServiceInterface) -> StringServiceInterface {

        let stringServiceInterface = StringService.shared

        stringServiceInterface.windowService = windowService
        stringServiceInterface.languageService = languageService

        return stringServiceInterface

    }

}
