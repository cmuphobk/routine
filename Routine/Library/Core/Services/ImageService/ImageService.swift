import UIKit

class ImageService: ImageServiceInterface {

    var languageService: LanguageServiceInterface!

    func localizeById(_ identifier: String) -> UIImage {
        let string = String(format: "%@_%@", identifier, self.languageService.currentLanguage().code)
        return UIImage(named: string) ?? UIImage(named: identifier) ?? UIImage()
    }

}
