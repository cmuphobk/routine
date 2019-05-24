import Foundation

protocol StringServiceInterface: RoutineDelegate {
    func localizeId(_ text: String) -> String
    func pluralsLocalizeId(str1: String, str24: String, str5: String, count: Int) -> String
    
    var styleHtmlString: String { get set }
    func localizeHtmlById(_ stringId: String) -> String
}

extension StringServiceInterface {
    func localize(_ text: String) -> String {
        return self.localizeId(text)
    }
}
