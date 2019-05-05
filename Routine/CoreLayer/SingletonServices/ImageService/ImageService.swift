import UIKit

class ImageService: ImageServiceInterface {
    
    var languageService: LanguageServiceInterface!
    
    static var shared = ImageService()
    
    private init () {}
    
    func localizeById(_ identifier: String) -> UIImage {
        return UIImage(named: String(format: "%@_%@", identifier, self.languageService.currentLanguage().code))  ??  UIImage(named: identifier)  ??  UIImage()
    }
    
}
