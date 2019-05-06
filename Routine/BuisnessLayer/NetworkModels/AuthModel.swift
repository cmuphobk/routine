import Foundation

struct RegisterRequestModel: Codable {
    var login: String
    var password: String
    var firstname: String
    var gender: String
    var birthDate: String
    var idCity: Int
    var loginToken: String?
}

struct AuthRequestModel: Codable {
    let login: String
    let password: String
    var loginToken: String?
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    init(login: String, password: String, loginToken: String) {
        self.login = login
        self.password = password
        self.loginToken = loginToken
    }
}

struct AuthResponseModel: Codable {
    var bearer: String?
    var refresh: String?
    var errors: [BaseResponeErrorModel]?
}

struct CodeRequestModel: Codable {
    var login: String
}

struct CheckCodeRequestModel: Codable {
    var login: String
    var code: String
}

struct CheckCodeResponseModel: Codable {
    var loginToken: String?
    var errors: [BaseResponeErrorModel]?
}

struct CheckLoginRequestModel: Codable {
    var login: String
    var loginToken: String
}

struct CheckLoginResponseModel: Codable {
    var exists: Bool?
    var errors: [BaseResponeErrorModel]?
}

struct RecoveryPasswordRequestModel: Codable {
    var login: String
    var newPassword: String
    var loginToken: String
}
