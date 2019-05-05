import Foundation

protocol StringServiceInterface {
    
    func localizeById(_ stringId: String) -> String
    
    func pluralsLocalizeByIds(str1: String, str24: String, str5: String, count: Int) -> String
    
    func localizeHtmlById(_ stringId: String) -> String
    
}
