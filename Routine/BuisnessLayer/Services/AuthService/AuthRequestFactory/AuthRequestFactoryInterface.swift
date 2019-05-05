
import Foundation

protocol AuthRequestFactoryInterface {
    
    func makeObtainGuestTokenRequest(_ model: TokenHeaderModel) -> RESTOperation<TokenResponseModel>?
    
    func makeRegisterRequest(_ model: TokenHeaderModel, registerRequestModel: RegisterRequestModel) -> RESTOperation<AuthResponseModel>?
    
    func makeAuthentificateRequest(_ model: TokenHeaderModel, authRequestModel: AuthRequestModel) -> RESTOperation<AuthResponseModel>?
    
    func makeSendCodeRequest(_ model: TokenHeaderModel, codeRequestModel: CodeRequestModel) -> RESTOperation<EmptyResponseModel>?
    
    func makeCheckCodeRequest(_ model: TokenHeaderModel, checkCodeRequestModel: CheckCodeRequestModel) -> RESTOperation<CheckCodeResponseModel>?
    
    func makeRecoveryPasswordRequest(_ model: TokenHeaderModel, recoveryPasswordRequestModel: RecoveryPasswordRequestModel) -> RESTOperation<EmptyResponseModel>?
    
    func makeObtainCitiesRequest(_ model: TokenHeaderModel) -> RESTOperation<CitiesResponseModel>?

}
