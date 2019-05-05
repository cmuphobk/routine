
import Foundation

enum RESTCode: Int, Codable {
    
    case incorrectLoginPasswordError = 4000201
    case needAcceptLoginError        = 4000202
    case incorrectTokenError         = 4000203
    case blockLoginError             = 4000204
    
    case incorrectLoginError         = 4000301
    case oftenCodeRequestError       = 4000302
    
    case incorrectCodeError          = 4000311
    case needNewCodeError            = 4000312
    
    case incorrectNameError          = 4000401
    case incorrectGenderError        = 4000402
    case incorrectBirthdayError      = 4000403
    case incorrectCityError          = 4000404
    case incorrectPasswordError      = 4000409
    case alreadyRegisterLoginError   = 4000410
    
    case refreshTokenExpiredError    = 4000601
    case incorrectRefreshTokenError  = 4000602
    
    case loginUnregisterError        = 4000501
    
    case incorrectSecondnameError    = 4000405
    case incorrectLastnameError      = 4000406
    
    case incorrectOldPasswordError   = 4000701
    
    case incorrectOldLoginTokenError = 4000801
    case equalLoginError             = 4000802
    
    case notCurrentUserLoginError    = 4000901
    case removeLastLoginError        = 4000902
    
    case loginExistError             = 4000205
    case incorrectNewPasswordError   = 4000702
    
}
