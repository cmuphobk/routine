
import UIKit

protocol ProfileModuleInput: class {
    func configureModule(login: String, password: String)
}

protocol ProfileViewInput: class {
    func setupInitialState()
    func configure(_ cities: [CityModel])
}

protocol ProfileViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func didTriggerNextButton(profile: ProfileViewModel)
    func didTriggerCancelButton()
}

protocol ProfileModuleRouting: class {
    func closeModule()
    func nextModule()
    func showErrorMessageWithText(_ string: String)
    func showLoader()
    func hideLoader()
}
