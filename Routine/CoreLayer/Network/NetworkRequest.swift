import Foundation

enum NetworkConstants: String {
    
    static var baseURL = "http://routineapi/v1/"
    
    case root = ""
    
    var url: String {
        return NetworkConstants.baseURL + self.rawValue
    }
    
}
