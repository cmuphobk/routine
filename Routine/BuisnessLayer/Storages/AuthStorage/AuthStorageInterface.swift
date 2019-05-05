import Foundation

protocol AuthStorageInterface {
        
    func receiveToken() -> String
    
    func saveToken(_ token: String)
    
    func removeToken()
    
    func receiveGuestToken() -> String
    
    func saveGuestToken(_ token: String)
    
    func removeGuestToken()
    
    func receiveLoginToken() -> String
    
    func saveLoginToken(_ loginToken: String)
    
    func removeLoginToken()
    
    func receiveRefreshToken() -> String
    
    func saveRefreshToken(_ refreshToken: String)
    
    func removeRefreshToken()
    
}
