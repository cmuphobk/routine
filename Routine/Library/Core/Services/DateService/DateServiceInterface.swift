import Foundation

protocol DateServiceInterface {
    
    func localizeDateString(date: Date, format: String) -> String
    
}
