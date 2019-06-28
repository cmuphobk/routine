import Foundation

enum ImageServiceAssembly {
    static func build(languageService: LanguageServiceInterface) -> ImageServiceInterface {
        let imageServiceInterface = ImageService()
        imageServiceInterface.languageService = languageService
        return imageServiceInterface
    }
}
