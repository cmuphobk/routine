import Foundation

final class AuthStorage: AuthStorageInterface {
    
    var storageService: StorageServiceInterface!
    
    private let kTokenIdentifier = "kTokenIdentifier"
    private let kLoginTokenIdentifier = "kLoginTokenIdentifier"
    private let kRefreshTokenIdentifier = "kRefreshTokenIdentifier"
    private let kGuestTokenIdentifier = "kGuestTokenIdentifier"
    
    init() {}
    
    // MARK: - Token
    func receiveToken() -> String {
        guard let token = self.storageService.string(forKey: kTokenIdentifier) else { return "none" }
        return token
    }
    func saveToken(_ token: String) {
        self.storageService.set(token, forKey: kTokenIdentifier)
    }
    func removeToken() {
        self.storageService.removeObject(forKey: kTokenIdentifier)
    }
    
    // MARK: - Guest Token
    func receiveGuestToken() -> String {
        guard let token = self.storageService.string(forKey: kGuestTokenIdentifier) else { return "none" }
        return token
    }
    func saveGuestToken(_ token: String) {
        self.storageService.set(token, forKey: kGuestTokenIdentifier)
    }
    func removeGuestToken() {
        self.storageService.removeObject(forKey: kGuestTokenIdentifier)
    }
    
    // MARK: - Login Token
    func receiveLoginToken() -> String {
        guard let loginToken = self.storageService.string(forKey: kLoginTokenIdentifier) else { return "none" }
        return loginToken
    }
    func saveLoginToken(_ loginToken: String) {
        self.storageService.set(loginToken, forKey: kLoginTokenIdentifier)
    }
    func removeLoginToken() {
        self.storageService.removeObject(forKey: kLoginTokenIdentifier)
    }
    
    // MARK: - Refresh Token
    func receiveRefreshToken() -> String {
        guard let refreshToken = self.storageService.string(forKey: kRefreshTokenIdentifier) else { return "none" }
        return refreshToken
    }
    func saveRefreshToken(_ refreshToken: String) {
        self.storageService.set(refreshToken, forKey: kRefreshTokenIdentifier)
    }
    func removeRefreshToken() {
        self.storageService.removeObject(forKey: kRefreshTokenIdentifier)
    }
    
}
