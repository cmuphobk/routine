import Foundation

protocol LanguageServiceInterface: class {
    
    var bundle: Bundle? { get set }
    
    func languagesList() -> [String]
    
    func setLanguage(languageName: String?)
    
    func currentLanguage() -> Language
    
    func resetLanguage() -> Language 
}
