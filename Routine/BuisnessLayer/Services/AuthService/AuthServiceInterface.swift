import Foundation

protocol AuthServiceInterface {
    
    var authStorage: AuthStorageInterface! { get }
    
    var isAuth: Bool { get }
    
    func obtainGuestToken(completion: @escaping (RESTOperationHandler<TokenResponseModel>?) -> Void)
    
    func registerWithModel(_ model: RegisterRequestModel, completion: @escaping (RESTOperationHandler<AuthResponseModel>?) -> Void)
    
    func authentificateWithAuthModel(_ model: AuthRequestModel, completion: @escaping (RESTOperationHandler<AuthResponseModel>?) -> Void)
    
    func sendCodeWithModel(_ model: CodeRequestModel, completion: @escaping (RESTOperationHandler<EmptyResponseModel>?) -> Void)
    
    func checkCodeWithModel(_ model: CheckCodeRequestModel, completion: @escaping (RESTOperationHandler<CheckCodeResponseModel>?) -> Void)
        
    func recoveryPasswordWithModel(_ model: RecoveryPasswordRequestModel, completion: @escaping (RESTOperationHandler<EmptyResponseModel>?) -> Void)
    
    func obtainCitiesWithModel(_ completion: @escaping (RESTOperationHandler<CitiesResponseModel>?) -> Void)
        
    func deauthorize()
    
}
