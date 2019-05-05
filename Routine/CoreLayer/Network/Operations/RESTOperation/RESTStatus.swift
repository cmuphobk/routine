
import Foundation

enum RESTStatus: Int {
    
    case unknown       = 0
    case informational = 100
    case success       = 200
    case redirection   = 300
    case clientError   = 400
    case serverError   = 500
    
}
