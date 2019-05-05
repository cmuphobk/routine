
import Foundation

enum NetworkConstants: String {
    
    case baseURL = "http://routineapi/v1/"
    
    case token = "auth/token"
    
    case register = "auth/register"
    
    case login = "auth/login"
    
    case sendCode = "auth/send-code"
    
    case checkCode = "auth/check-code"
    
    case recoveryPassword = "auth/recovery-password"
    
    case cities = "directory/cities"
    
    var url: String {
        return NetworkConstants.baseURL.rawValue + self.rawValue
    }
    
}
