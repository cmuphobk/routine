import UIKit

final class RegistrationViewController: RoutineViewController {
    var output: RegistrationViewOutput!
    var windowService: WindowServiceInterface!
    
    @IBOutlet weak private var titleTextLabel: UILabel!
    @IBOutlet weak private var descriptionTextLabel: UILabel!
    @IBOutlet weak private var loginTextField: StandartTextField!
    @IBOutlet weak private var passwordTextField: StandartPasswordTextField!
    @IBOutlet weak private var passwordRepeatTextField: StandartPasswordTextField!
    @IBOutlet weak private var agreementMedicineCheckBoxButton: StandartCheckBox!
    @IBOutlet weak private var agreementMedicineCheckBoxTextView: StandartHtmlTextView!
    @IBOutlet weak private var agreementLicenseCheckBoxButton: StandartCheckBox!
    @IBOutlet weak private var agreementLicenseCheckBoxTextView: StandartHtmlTextView!
    @IBOutlet weak private var registrationButton: StandartAcceptButton!
    @IBOutlet weak private var htmlTextView: StandartHtmlTextView!
    
    @IBOutlet weak private var heightHtmlTextViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightMedicineConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightLicenseConstraint: NSLayoutConstraint!
    
    @IBOutlet weak private var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak private var heightConstraint: NSLayoutConstraint!
    
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
        self.navigationItem.title = nil
        
        self.loginTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("login_placeholder_string")
        self.passwordTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("password_placeholder_string")
        self.passwordRepeatTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("password_repeat_placeholder_string")
        self.titleTextLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("registration_title_string")
        self.descriptionTextLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("registration_desc_string")
        
        self.agreementMedicineCheckBoxTextView.htmlText = AppDelegate.serviceProvider.makeStringService().localizeHtmlById("registration_med_aggrement_string")
        self.heightMedicineConstraint.constant = self.agreementMedicineCheckBoxTextView.fullHeight
        
        self.agreementLicenseCheckBoxTextView.htmlText = AppDelegate.serviceProvider.makeStringService().localizeHtmlById("registration_lic_aggrement_string")
        self.heightLicenseConstraint.constant = self.agreementLicenseCheckBoxTextView.fullHeight
        self.registrationButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("registration_button_string"), for: .normal)
        
        self.htmlTextView.htmlText = AppDelegate.serviceProvider.makeStringService().localizeHtmlById("registration_bottom_string_html")
        self.heightHtmlTextViewConstraint.constant = self.htmlTextView.fullHeight
        
    }
    
    @IBAction func loginChanged(_ sender: UITextField) {
//        guard let text = sender.text else { return }
//        let isDigit = Int(text) != nil
//
//        if text.count == 1 && isDigit {
//            sender.text = "+7" + text
//
//        } else if text.elementsEqual("+") {
//            sender.text?.removeAll()
//        }
    }
    
    @IBAction private func agreementMedicineButtonAction(_ sender: Any) {
        self.blueButtonValidate()
    }
    @IBAction private func agreementLicenseButtonAction(_ sender: Any) {
        self.blueButtonValidate()
    }
    
    @IBAction private func registrationButtonAction(_ sender: Any) {
        self.output.didTriggerRegistrationButton(login: self.loginTextField.text ?? "", password: self.passwordTextField.text ?? "")
    }
}

// MARK: - RegistrationViewInput
extension RegistrationViewController: RegistrationViewInput {
    
    func setupInitialState() {
        
        let is5sAndLess = self.windowService.is5sAndLess
        
        self.topConstraint.constant = is5sAndLess ? 0 : 50
        
        self.heightConstraint.constant = is5sAndLess ? 30 : 50
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapEvent)))
        
        self.titleTextLabel.font = FontProvider.registratonFonts.titleLabel
        self.titleTextLabel.numberOfLines = 1
        self.titleTextLabel.textColor = ColorProvider.default.blackColor
        self.titleTextLabel.textAlignment = .center
        
        self.descriptionTextLabel.font = FontProvider.registratonFonts.descriptionLabel
        self.descriptionTextLabel.numberOfLines = 0
        self.descriptionTextLabel.textColor = ColorProvider.default.blackColor
        self.descriptionTextLabel.textAlignment = .center
        
        self.loginTextField.delegate = self
        self.loginTextField.returnKeyType = .next
        self.loginTextField.font = FontProvider.default.textFieldButton
        self.loginTextField.textAlignment = .center
        self.loginTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        self.passwordTextField.delegate = self
        self.passwordTextField.returnKeyType = .next
        self.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        self.passwordRepeatTextField.delegate = self
        self.passwordRepeatTextField.returnKeyType = .done
        self.passwordRepeatTextField.isMainField = false
        self.passwordRepeatTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        self.agreementLicenseCheckBoxTextView.delegate = self
        self.agreementLicenseCheckBoxTextView.font = is5sAndLess ? FontProvider.registratonFonts.agreementSmallLabel : FontProvider.registratonFonts.agreementLabel
        
        self.agreementMedicineCheckBoxTextView.delegate = self
        self.agreementMedicineCheckBoxTextView.font = is5sAndLess ? FontProvider.registratonFonts.agreementSmallLabel : FontProvider.registratonFonts.agreementLabel
        
        self.registrationButton.isEnabled = false
        
        self.htmlTextView.delegate = self
        
    }
    
}

// MARK: - UITextViewDelegate
extension RegistrationViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let string = URL.lastPathComponent
        if string == "auth" {
            self.output.didTriggerAuthButton()
        } else if string == "license" {
            self.output.didTriggerOpenLicense()
        } else if string == "medicine" {
            self.output.didTriggerOpenMedicine()
        }
        
        return false
        
    }
    
}

// MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.loginTextField {
            
            self.loginTextField.resignFirstResponder()
            self.passwordTextField.becomeFirstResponder()
            self.blueButtonValidate()
            
        } else if textField == self.passwordTextField {
            
            self.passwordTextField.resignFirstResponder()
            self.passwordRepeatTextField.becomeFirstResponder()
            self.blueButtonValidate()
            
        } else if textField == self.passwordRepeatTextField {
            
            self.passwordRepeatTextField.resignFirstResponder()
            self.blueButtonValidate()
            
        }
        
        return true
    }
    
}

// MARK: - Private
extension RegistrationViewController {
    
    @objc private func textFieldDidChange(textField: UITextField) {
        
        self.blueButtonValidate()
        
    }
    
    @objc private func viewTapEvent(gestureRecognizer: UIGestureRecognizer) {
        
        self.loginTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.passwordRepeatTextField.resignFirstResponder()
        
        self.blueButtonValidate()
        
    }
    
    private func blueButtonValidate() {
        
        if self.passwordRepeatTextField.text != nil && self.passwordRepeatTextField.text != "" {
            self.passwordRepeatTextField.isOk = self.passwordTextField.text == self.passwordRepeatTextField.text
        } else {
            self.passwordRepeatTextField.isOk = nil
        }
        
        self.registrationButton.isEnabled = self.loginTextField.text != nil && self.loginTextField.text != ""  && self.passwordTextField.text != nil && self.passwordTextField.text != "" && self.passwordRepeatTextField.text != nil && self.passwordRepeatTextField.text != "" && self.passwordTextField.text == self.passwordRepeatTextField.text && self.agreementLicenseCheckBoxButton.isChecked && self.agreementMedicineCheckBoxButton.isChecked
        
    }
    
    private func clearScreen () {
        
        self.loginTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.passwordRepeatTextField.resignFirstResponder()
        
        self.loginTextField.text = nil
        self.passwordTextField.text = nil
        self.passwordTextField.isSecureTextEntry = true
        self.passwordRepeatTextField.text = nil
        self.agreementLicenseCheckBoxButton.isChecked = false
        self.agreementMedicineCheckBoxButton.isChecked = false
        self.blueButtonValidate()
        
    }
}
