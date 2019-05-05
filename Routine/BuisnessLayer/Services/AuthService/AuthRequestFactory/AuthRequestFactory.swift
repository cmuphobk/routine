
import Foundation
import Alamofire

final class AuthRequestFactory: AuthRequestFactoryInterface {
    
    func makeObtainGuestTokenRequest(_ model: TokenHeaderModel) -> RESTOperation<TokenResponseModel>? {
        
        let url = NetworkConstants.token.url
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        let headers = try? model.asDictionary()
        
        let requestObject = RESTRequestObject(method: .get, encoding: URLEncoding.default, parameters: nil, headers: headers as? HTTPHeaders, url: encodedUrl)
        let networkOperationHandler = RESTOperationHandler<TokenResponseModel>(withRequestObject: requestObject)
        let networkOperation = RESTOperation<TokenResponseModel>(withHandler: networkOperationHandler)
        
        return networkOperation
        
    }
    
    func makeRegisterRequest(_ model: TokenHeaderModel, registerRequestModel: RegisterRequestModel) -> RESTOperation<AuthResponseModel>? {
        
        let url = NetworkConstants.register.url
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        let headers = try? model.asDictionary()
        
        let requestObject = RESTRequestObject(method: .post, encoding: JSONEncoding.default, parameters: try? registerRequestModel.asDictionary(), headers: headers as? HTTPHeaders, url: encodedUrl)
        let networkOperationHandler = RESTOperationHandler<AuthResponseModel>(withRequestObject: requestObject)
        let networkOperation = RESTOperation<AuthResponseModel>(withHandler: networkOperationHandler)
        
        return networkOperation
    }
    
    func makeAuthentificateRequest(_ model: TokenHeaderModel, authRequestModel: AuthRequestModel) -> RESTOperation<AuthResponseModel>? {
        
        let url = NetworkConstants.login.url
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        let headers = try? model.asDictionary()
        
        let requestObject = RESTRequestObject(method: .post, encoding: JSONEncoding.default, parameters: try? authRequestModel.asDictionary(), headers: headers as? HTTPHeaders, url: encodedUrl)
        let networkOperationHandler = RESTOperationHandler<AuthResponseModel>(withRequestObject: requestObject)
        let networkOperation = RESTOperation<AuthResponseModel>(withHandler: networkOperationHandler)
        
        return networkOperation
    }
    
    func makeSendCodeRequest(_ model: TokenHeaderModel, codeRequestModel: CodeRequestModel) -> RESTOperation<EmptyResponseModel>? {
        
        let url = NetworkConstants.sendCode.url
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        let headers = try? model.asDictionary()
        
        let requestObject = RESTRequestObject(method: .post, encoding: JSONEncoding.default, parameters: try? codeRequestModel.asDictionary(), headers: headers as? HTTPHeaders, url: encodedUrl)
        let networkOperationHandler = RESTOperationHandler<EmptyResponseModel>(withRequestObject: requestObject)
        let networkOperation = RESTOperation<EmptyResponseModel>(withHandler: networkOperationHandler)
        
        return networkOperation
    }
    
    func makeCheckCodeRequest(_ model: TokenHeaderModel, checkCodeRequestModel: CheckCodeRequestModel) -> RESTOperation<CheckCodeResponseModel>? {
        
        let url = NetworkConstants.checkCode.url
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        let headers = try? model.asDictionary()
        
        let requestObject = RESTRequestObject(method: .post, encoding: JSONEncoding.default, parameters: try? checkCodeRequestModel.asDictionary(), headers: headers as? HTTPHeaders, url: encodedUrl)
        let networkOperationHandler = RESTOperationHandler<CheckCodeResponseModel>(withRequestObject: requestObject)
        let networkOperation = RESTOperation<CheckCodeResponseModel>(withHandler: networkOperationHandler)
        
        return networkOperation
    }
    
    func makeRecoveryPasswordRequest(_ model: TokenHeaderModel, recoveryPasswordRequestModel: RecoveryPasswordRequestModel) -> RESTOperation<EmptyResponseModel>? {
        
        let url = NetworkConstants.recoveryPassword.url
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        let headers = try? model.asDictionary()
        
        let requestObject = RESTRequestObject(method: .post, encoding: JSONEncoding.default, parameters: try? recoveryPasswordRequestModel.asDictionary(), headers: headers as? HTTPHeaders, url: encodedUrl)
        let networkOperationHandler = RESTOperationHandler<EmptyResponseModel>(withRequestObject: requestObject)
        let networkOperation = RESTOperation<EmptyResponseModel>(withHandler: networkOperationHandler)
        
        return networkOperation
    }
    
    func makeObtainCitiesRequest(_ model: TokenHeaderModel) -> RESTOperation<CitiesResponseModel>? {
        
        let url = NetworkConstants.cities.url
        
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        let headers = try? model.asDictionary()
        
        let cityModel = CitiesRequestModel(order: "title")
        
        let requestObject = RESTRequestObject(method: .get, encoding: URLEncoding.default, parameters: try? cityModel.asDictionary(), headers: headers as? HTTPHeaders, url: encodedUrl)
        let networkOperationHandler = RESTOperationHandler<CitiesResponseModel>(withRequestObject: requestObject)
        let networkOperation = RESTOperation<CitiesResponseModel>(withHandler: networkOperationHandler)
        
        return networkOperation
    }
    
}
