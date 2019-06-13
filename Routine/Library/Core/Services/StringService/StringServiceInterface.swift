import Foundation

protocol StringServiceInterface {
    var styleHtmlString: String { get set }

    func localizeId(_ text: String) -> String
    func localizeHtmlById(_ stringId: String) -> String
    func pluralsLocalizeId(str1: String, str24: String, str5: String, count: Int) -> String
}
