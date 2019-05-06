import UIKit
import DateToolsSwift

struct ProfileViewModel {
    
    var name: String
    var genderCode: String
    var date: String
    var cityId: Int
    
}

final class ProfileViewController: RoutineViewController {
    var output: ProfileViewOutput!
    var windowService: WindowServiceInterface!
    var notificationService: NotificationServiceInterface!
    
    @IBOutlet weak private var logoImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var nameTextField: UITextField!
    
    @IBOutlet weak private var genderTextField: UITextField!
    weak private var genderPickerView: StandartPickerView!
    
    @IBOutlet weak private var dateTextField: UITextField!
    weak private var datePickerView: StandartDatePickerView!
    
    @IBOutlet weak private var cityTextField: UITextField!
    weak private var cityPickerView: StandartPickerView!
    
    @IBOutlet weak private var nextButton: StandartAcceptButton!
    @IBOutlet weak private var cancelButton: UIButton!
    
    @IBOutlet weak private var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var bottomCancelConstraint: NSLayoutConstraint!
    
    private var cities: [CityModel] = []
    
    private var profileViewModel: ProfileViewModel!
    
    private var genders = [Gender.male, Gender.female]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.didTriggerViewReadyEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.didTriggerViewWillAppear()
        
        self.navigationController?.configureTransparentNavigationBar()
        self.emptyCustomBarLeftButtonAction()
        
        self.clearScreen()
    }
    
    override func localizationSetup() {
        super.localizationSetup()
        self.navigationItem.title = ""
        
        self.logoImageView.image = ImageProvider.profileImages.logoIcon
        
        self.titleLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("profile_header_string")
        self.descriptionLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("profile_description_string")
        
        self.nameTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("profile_name_placeholder_string")
        self.genderTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("profile_gender_placeholder_string")
        self.dateTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("profile_date_placeholder_string")
        self.cityTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("profile_city_placeholder_string")
        
        self.nextButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("profile_next_string"), for: .normal)
        self.cancelButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("profile_cancel_string"), for: .normal)

    }
    @IBAction private func nextButtonAction(_ sender: Any) {
        self.profileViewModel.name = self.nameTextField.text ?? ""
        self.output.didTriggerNextButton(profile: self.profileViewModel)
    }
    @IBAction private func cancelButtonAction(_ sender: Any) {
        self.output.didTriggerCancelButton()
    }
    
}

// MARK: - ProfileViewInput
extension ProfileViewController: ProfileViewInput {
    
    func configure(_ cities: [CityModel]) {
        self.cities = cities
    }
    
    func setupInitialState() {
        
        let is5sAndLess = self.windowService.is5sAndLess
                
        self.heightConstraint.constant = is5sAndLess ? 30 : 50
        self.bottomCancelConstraint.constant = is5sAndLess ? 40 : 76
        
        self.logoImageView.contentMode = .scaleAspectFit
        
        self.titleLabel.font = FontProvider.profileFonts.titleLabel
        self.titleLabel.numberOfLines = 1
        self.titleLabel.textColor = ColorProvider.default.blackColor
        self.titleLabel.textAlignment = .center
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapEvent)))
        
        self.descriptionLabel.font = is5sAndLess ? FontProvider.profileFonts.descriptionSmallLabel : FontProvider.profileFonts.descriptionLabel
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textColor = ColorProvider.default.blackColor
        self.descriptionLabel.textAlignment = .center
        
        self.nameTextField.delegate = self
        self.nameTextField.returnKeyType = .next
        self.nameTextField.font = FontProvider.default.textFieldButton
        self.nameTextField.textAlignment = .center
        
        self.genderTextField.delegate = self
        self.genderTextField.font = FontProvider.default.textFieldButton
        self.genderTextField.textAlignment = .left
        
        self.dateTextField.delegate = self
        self.dateTextField.font = FontProvider.default.textFieldButton
        self.dateTextField.textAlignment = .center
        
        self.cityTextField.delegate = self
        self.cityTextField.font = FontProvider.default.textFieldButton
        self.cityTextField.textAlignment = .center
        
        self.cancelButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
        self.cancelButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        
        self.nextButton.isEnabled = false
        
        self.notificationService.addObserver(self, selector: #selector(keyboardAppearEvent), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    
        self.profileViewModel = ProfileViewModel(name: "", genderCode: "", date: "", cityId: 0)
    }
    
}

// MARK: - UITextFieldDelegate
extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.hideAllPickers()
        
        if textField == self.genderTextField {
            
            guard let genderPickerView = self.genderPickerView else {
                
                let genderPickerView = StandartPickerView(models: self.genders, currentValue: textField.text ?? "", frame: self.view.bounds, delegate: self, leftTitle: AppDelegate.serviceProvider.makeStringService().localizeById("back_string"), rightTitle: AppDelegate.serviceProvider.makeStringService().localizeById("ok_string"))
                self.view.addSubview(genderPickerView)
                self.genderPickerView = genderPickerView
                
                return false
            }
            
            self.view.addSubview(genderPickerView)
            
            return false
        } else if textField == self.dateTextField {
            
            guard let datePickerView = self.datePickerView else {
                let datePickerView = StandartDatePickerView(frame: self.view.bounds, delegate: self, leftTitle: AppDelegate.serviceProvider.makeStringService().localizeById("back_string"), rightTitle: AppDelegate.serviceProvider.makeStringService().localizeById("ok_string"))
                self.view.addSubview(datePickerView)
                self.datePickerView = datePickerView
                return false
            }
            self.view.addSubview(datePickerView)
            return false
        } else if textField == self.cityTextField {
            
            guard let cityPickerView = self.cityPickerView else {
                let cityPickerView = StandartPickerView(models: self.cities, currentValue: textField.text ?? "", frame: self.view.bounds, delegate: self, leftTitle: AppDelegate.serviceProvider.makeStringService().localizeById("back_string"), rightTitle: AppDelegate.serviceProvider.makeStringService().localizeById("ok_string"))
                self.view.addSubview(cityPickerView)
                self.cityPickerView = cityPickerView
                return true
            }
            self.view.addSubview(cityPickerView)
            return true
        }
        
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.nameTextField {
            
            self.nameTextField.resignFirstResponder()
            self.blueButtonValidate()
            
        }
        
        return true
    }
    
}

// MARK: - StandartPickerDelegate
extension ProfileViewController: StandartPickerDelegate {
    
    func leftButtonAction(_ pickerView: StandartPickerView) {
        pickerView.removeFromSuperview()
    }
    
    func rightButtonAction(_ pickerView: StandartPickerView) {
        let row = pickerView.pickerView.selectedRow(inComponent: 0)
        if pickerView == self.genderPickerView {
            self.genderTextField.text = self.genders[row].title
            self.profileViewModel.genderCode = self.genders[row].genderCode ?? ""
        } else if pickerView == self.cityPickerView {
            if self.cities.count == 0 { return }
            let cityModel = self.cities[row]
            self.cityTextField.text = cityModel.title
            self.profileViewModel.cityId = cityModel.code
        }
        pickerView.removeFromSuperview()
    }
    
    func standartPickerView(_ pickerView: StandartPickerView, didSelectRow row: Int) {
        if pickerView == self.genderPickerView {
            self.genderTextField.text = self.genders[row].title
            self.profileViewModel.genderCode = self.genders[row].genderCode ?? ""
        } else if pickerView == self.cityPickerView {
            if self.cities.count == 0 { return }
            let cityModel = self.cities[row]
            self.cityTextField.text = cityModel.title
            self.profileViewModel.cityId = cityModel.code
        }
    }
    
}

// MARK: - StandartDatePickerViewDelegate
extension ProfileViewController: StandartDatePickerViewDelegate {
    
    func leftButtonAction(_ pickerView: StandartDatePickerView) {
        pickerView.removeFromSuperview()
    }
    
    func rightButtonAction(_ pickerView: StandartDatePickerView) {
        if pickerView == self.datePickerView {
            
            self.dateTextField.text = AppDelegate.serviceProvider.makeDateService().localizeDateString(date: pickerView.date, format: "dd MMM yyyy")
            self.profileViewModel.date = pickerView.date.format(with: "yyyy-MM-dd")
        }
        pickerView.removeFromSuperview()
    }
    
    func standartDatePickerViewDelegate(_ datePickerView: StandartDatePickerView, didSelectDate date: Date) {
        if datePickerView == self.datePickerView {
            
            self.dateTextField.text = AppDelegate.serviceProvider.makeDateService().localizeDateString(date: date, format: "dd MMM yyyy")
            self.profileViewModel.date = date.format(with: "yyyy-MM-dd")
        }
    }
    
}

// MARK: - Private
extension ProfileViewController {
    
    @objc func keyboardAppearEvent(notification: NSNotification) {
        
        self.cityTextField.resignFirstResponder()
        
    }
    
    @objc func viewTapEvent(gestureRecognizer: UIGestureRecognizer) {
        
        self.nameTextField.resignFirstResponder()
        
        self.hideAllPickers()
        
        self.blueButtonValidate()
        
    }
    
    private func hideAllPickers() {
        
        self.nameTextField.resignFirstResponder()
        
        self.genderPickerView?.removeFromSuperview()
        
        self.datePickerView?.removeFromSuperview()
        
        self.cityTextField.resignFirstResponder()
        self.cityPickerView?.removeFromSuperview()
        
        self.blueButtonValidate()
        
    }
    
    private func blueButtonValidate() {
        
        self.nextButton.isEnabled = self.nameTextField.text != nil && self.nameTextField.text != ""  && self.genderTextField.text != nil && self.genderTextField.text != "" && self.dateTextField.text != nil && self.dateTextField.text != "" && self.cityTextField.text != nil && self.cityTextField.text != ""
        
    }
    
    private func clearScreen () {
        
        self.nameTextField.resignFirstResponder()
        self.genderTextField.resignFirstResponder()
        self.dateTextField.resignFirstResponder()
        self.cityTextField.resignFirstResponder()
        
        self.nameTextField.text = nil
        self.genderTextField.text = nil
        self.dateTextField.text = nil
        self.cityTextField.text = nil
        self.blueButtonValidate()
        
    }
    
}
