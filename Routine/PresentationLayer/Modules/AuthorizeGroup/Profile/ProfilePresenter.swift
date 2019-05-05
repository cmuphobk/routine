
import UIKit

let kProfileModuleId = "profile_name"

final class ProfilePresenter: Module {
    weak var view: ProfileViewInput?
    var router: ProfileModuleRouting!
    var authService: AuthServiceInterface!
    var authStorage: AuthStorageInterface!
    
    var name = kProfileModuleId
    var alias = "profile_alias"
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
    
    private var login: String!
    private var password: String!
    
    private var cities: [CityModel] = []
}

// MARK: - ProfileModuleInput
extension ProfilePresenter: ProfileModuleInput {
    
    func configureModule(login: String, password: String) {
        self.login = login
        self.password = password
        
        self.router.showLoader()
        
        self.authService.obtainCitiesWithModel { [unowned self] (handler) in
            
            guard let handler = handler else {
                self.router.hideLoader()
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("cities_error_string"))
                return
            }
            
            if let errors = handler.decodeResponse?.errors, errors.count > 0 {
                for error in errors {
                    switch error.code {
                    default:
                        self.router.hideLoader()
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("cities_error_string"))
                    }
                }
            } else if handler.status == .success {
                self.router.hideLoader()
                self.cities = handler.decodeResponse?.cities?.map({ (model) -> CityModel in
                    return CityModel(name: model.title, code: model.identifier)
                }) ?? []
                
                self.view?.configure(self.cities)
                
            } else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("cities_error_string"))
                self.router.hideLoader()
            }
            
        }
    }
    
}

// MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {

    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
    }
    
    func didTriggerViewWillAppear() {
        
    }
    
    func didTriggerNextButton(profile: ProfileViewModel) {
        
        self.router.showLoader()
        
        self.authService.registerWithModel(RegisterRequestModel(login: self.login, password: self.password, firstname: profile.name, gender: profile.genderCode, birthDate: profile.date, idCity: profile.cityId, loginToken: self.authStorage.receiveLoginToken())) { [unowned self] (handler) in
            
            guard let handler = handler else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("profile_error_string"))
                self.router.hideLoader()
                return
            }
            
            if let errors = handler.decodeResponse?.errors, errors.count > 0 {

                for error in errors {
                    switch error.code {
                    case .incorrectTokenError?:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("profile_error_string"))
                        self.router.hideLoader()
                        self.router.closeModule()
                    case .incorrectNameError?:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("profile_incorrectNameError"))
                        self.router.hideLoader()
                    case .incorrectGenderError?:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("profile_incorrectGenderError"))
                        self.router.hideLoader()
                    case .incorrectBirthdayError?:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("profile_incorrectBirthdayError"))
                        self.router.hideLoader()
                    case .incorrectCityError?:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("profile_incorrectCityError"))
                        self.router.hideLoader()
                    case .alreadyRegisterLoginError?, .loginExistError?:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("profile_alreadyRegisterLoginError"))
                        self.router.hideLoader()
                    case .incorrectPasswordError?:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("profile_incorrectPasswordError"))
                        self.router.hideLoader()
                    default:
                        self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("profile_error_string"))
                        self.router.hideLoader()
                    }
                    
                }
            } else if handler.status == .success {
                self.router.hideLoader()
                self.router.nextModule()
            } else {
                self.router.showErrorMessageWithText(AppDelegate.serviceProvider.makeStringService().localizeById("profile_error_string"))
                self.router.hideLoader()
            }
            
        }
        
    }
    
    func didTriggerCancelButton() {
        self.router.closeModule()
    }
    
}
