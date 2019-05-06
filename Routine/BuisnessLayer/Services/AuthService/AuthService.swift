import Foundation
import Alamofire

final class AuthService: AuthServiceInterface {
    
    init () {  }
    
    var authRequestFactory: AuthRequestFactoryInterface!
    var authStorage: AuthStorageInterface!
    var operationQueue: OperationQueue!

    var isAuth: Bool {
        return self.authStorage.receiveToken() != "none"
    }
    
    func obtainGuestToken(completion: @escaping (RESTOperationHandler<TokenResponseModel>?) -> Void) {
        
        let tokenModel = TokenHeaderModel(authorization: self.authStorage.receiveGuestToken())
        
        guard let networkOperation = self.authRequestFactory.makeObtainGuestTokenRequest(tokenModel) else { return }
        
        networkOperation.completionBlock = { [weak networkOperation] in
            
            guard let handler = networkOperation?.handler else {
                OperationQueue.main.addOperation {
                    self.authStorage.removeGuestToken()
                    self.obtainGuestToken(completion: completion)
                }
                
                return
            }
            
            OperationQueue.main.addOperation {
                //если все ок
                if let responseObj = handler.decodeResponse, let token = responseObj.token {
                    self.authStorage.saveGuestToken(token)
                    completion(handler)
                //если неизвестная ошибка
                } else if handler.status != .unknown {
                    self.authStorage.removeGuestToken()
                    self.obtainGuestToken(completion: completion)
                //если известная ошибка (ошибка сервера и т.д. ломимся еще раз) вохможно стоит ввести счетчик повторяющихся запросов
                } else {
                    self.authStorage.removeGuestToken()
                    completion(nil)
                }
            }
            return
            
        }
        
        self.operationQueue.addOperations([networkOperation], waitUntilFinished: false)
        
    }
    
    func registerWithModel(_ model: RegisterRequestModel, completion: @escaping (RESTOperationHandler<AuthResponseModel>?) -> Void) {
        
        // гарантия токена
        self.obtainGuestToken { [unowned self] (handler) in
            
            guard let handler = handler else {
                completion(nil)
                return
            }
            
            let tokenModel = TokenHeaderModel(authorization: handler.decodeResponse?.token)
            
            guard let networkOperation = self.authRequestFactory.makeRegisterRequest(tokenModel, registerRequestModel: model) else { return }
            
            networkOperation.completionBlock = { [weak networkOperation] in
                guard let handler = networkOperation?.handler else {
                    OperationQueue.main.addOperation {
                        completion(nil)
                    }
                    return
                }
                
                OperationQueue.main.addOperation {
                    if let responseObj = handler.decodeResponse, let token = responseObj.bearer, let refreshToken = responseObj.refresh {
                        self.authStorage.saveToken(token)
                        self.authStorage.saveRefreshToken(refreshToken)
                    } else {
                        self.authStorage.removeToken()
                        self.authStorage.removeRefreshToken()
                    }
                    completion(handler)
                }
                return
                
            }
            
            self.operationQueue.addOperations([networkOperation], waitUntilFinished: false)
            
        }
        
    }
    
    func authentificateWithAuthModel(_ model: AuthRequestModel, completion: @escaping (RESTOperationHandler<AuthResponseModel>?) -> Void) {
        
        // гарантия токена
        self.obtainGuestToken { [unowned self] (handler) in
            
            guard let handler = handler else {
                completion(nil)
                return
            }
            
            let tokenModel = TokenHeaderModel(authorization: handler.decodeResponse?.token)
            
            guard let networkOperation = self.authRequestFactory.makeAuthentificateRequest(tokenModel, authRequestModel: model) else { return }
            
            networkOperation.completionBlock = { [weak networkOperation] in
                guard let handler = networkOperation?.handler else {
                    OperationQueue.main.addOperation {
                        completion(nil)
                    }
                    return
                }
                
                OperationQueue.main.addOperation {
                    if let responseObj = handler.decodeResponse, let token = responseObj.bearer, let refreshToken = responseObj.refresh {
                        self.authStorage.saveToken(token)
                        self.authStorage.saveRefreshToken(refreshToken)
                    } else {
                        self.authStorage.removeToken()
                        self.authStorage.removeRefreshToken()
                    }
                    completion(handler)
                }
                return
                
            }
            
            self.operationQueue.addOperations([networkOperation], waitUntilFinished: false)
            
        }
        
    }
    
    func sendCodeWithModel(_ model: CodeRequestModel, completion: @escaping (RESTOperationHandler<EmptyResponseModel>?) -> Void) {
        
        // гарантия токена
        self.obtainGuestToken { [unowned self] (handler) in
            
            guard let handler = handler else {
                completion(nil)
                return
            }
            
            let tokenModel = TokenHeaderModel(authorization: handler.decodeResponse?.token)
            
            guard let networkOperation = self.authRequestFactory.makeSendCodeRequest(tokenModel, codeRequestModel: model) else { return }
            
            networkOperation.completionBlock = { [weak networkOperation] in
                
                guard let handler = networkOperation?.handler else {
                    OperationQueue.main.addOperation {
                        completion(nil)
                    }
                    return
                }
                
                OperationQueue.main.addOperation {
                    completion(handler)
                }
                return
                
            }
            
            self.operationQueue.addOperations([networkOperation], waitUntilFinished: false)
            
        }
        
    }
    
    func checkCodeWithModel(_ model: CheckCodeRequestModel, completion: @escaping (RESTOperationHandler<CheckCodeResponseModel>?) -> Void) {
        
        // гарантия токена
        self.obtainGuestToken { [unowned self] (handler) in
            
            guard let handler = handler else {
                completion(nil)
                return
            }
            
            let tokenModel = TokenHeaderModel(authorization: handler.decodeResponse?.token)
            
            guard let networkOperation = self.authRequestFactory.makeCheckCodeRequest(tokenModel, checkCodeRequestModel: model) else { return }
            
            networkOperation.completionBlock = { [weak networkOperation] in
                
                guard let handler = networkOperation?.handler else {
                    OperationQueue.main.addOperation {
                        completion(nil)
                    }
                    return
                }
                
                OperationQueue.main.addOperation {
                    if handler.response != nil, let loginToken = handler.decodeResponse?.loginToken {
                        self.authStorage.saveLoginToken(loginToken)
                    } else {
                        self.authStorage.removeLoginToken()
                    }
                    completion(handler)
                }
                return
                
            }
            
            self.operationQueue.addOperations([networkOperation], waitUntilFinished: false)
            
        }
        
    }
    
    func recoveryPasswordWithModel(_ model: RecoveryPasswordRequestModel, completion: @escaping (RESTOperationHandler<EmptyResponseModel>?) -> Void) {
        
        // гарантия токена
        self.obtainGuestToken { [unowned self] (handler) in
            
            guard let handler = handler else {
                completion(nil)
                return
            }
            
            let tokenModel = TokenHeaderModel(authorization: handler.decodeResponse?.token)
            
            guard let networkOperation = self.authRequestFactory.makeRecoveryPasswordRequest(tokenModel, recoveryPasswordRequestModel: model) else { return }
            
            networkOperation.completionBlock = { [weak networkOperation] in
                
                guard let handler = networkOperation?.handler else {
                    OperationQueue.main.addOperation {
                        completion(nil)
                    }
                    return
                }
                
                OperationQueue.main.addOperation {
                    completion(handler)
                }
                return
                
            }
            
            self.operationQueue.addOperations([networkOperation], waitUntilFinished: false)
            
        }
        
    }
    
    func obtainCitiesWithModel(_ completion: @escaping (RESTOperationHandler<CitiesResponseModel>?) -> Void) {
        
        // гарантия токена
        self.obtainGuestToken { [unowned self] (handler) in
            
            guard let handler = handler else {
                completion(nil)
                return
            }
            
            let tokenModel = TokenHeaderModel(authorization: handler.decodeResponse?.token)
            
            guard let networkOperation = self.authRequestFactory.makeObtainCitiesRequest(tokenModel) else { return }
            
            networkOperation.completionBlock = { [weak networkOperation] in
                
                guard let handler = networkOperation?.handler else {
                    OperationQueue.main.addOperation {
                        completion(nil)
                    }
                    return
                }
                
                OperationQueue.main.addOperation {
                    completion(handler)
                }
                return
                
            }
            
            self.operationQueue.addOperations([networkOperation], waitUntilFinished: false)
            
        }
        
    }
    
    func deauthorize() {
        
        self.authStorage.removeToken()
        self.authStorage.removeRefreshToken()
        self.authStorage.removeGuestToken()
        self.authStorage.removeLoginToken()
        
    }
}
