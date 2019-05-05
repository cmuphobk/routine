import UIKit

final class AuthViewController: LocalizedViewController {
    var output: AuthViewOutput!
    var windowService: WindowServiceInterface!
    
    @IBOutlet weak private var logoImageView: UIImageView!
    @IBOutlet weak private var loginTextField: StandartTextField!
    @IBOutlet weak private var passwordTextField: StandartPasswordTextField!
    @IBOutlet weak private var enterButton: StandartAcceptButton!
    @IBOutlet weak private var registrationButton: UIButton!
    @IBOutlet weak private var forgotPasswordButton: UIButton!
    
    @IBOutlet weak private var topLoginConstraint: NSLayoutConstraint!
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
        
        self.logoImageView.image = ImageProvider.authImages.logoIcon
        
        self.loginTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("login_placeholder_string")
        self.passwordTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("password_placeholder_string")
        
        self.enterButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("enter_button_title_string"), for: .normal)
        self.registrationButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("registration_button_title_string"), for: .normal)
        self.forgotPasswordButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("forgot_button_title_string"), for: .normal)
    }
    
    // MARK: - IBActions
    
    @IBAction private func enterButtonAction(_ sender: Any) {
        
        self.output.didTriggerEnterButtonAction()
        
    }
    @IBAction private func registraionButtonAction(_ sender: Any) {
        
        self.output.didTriggerRegistrationButtonAction()
        
    }
    @IBAction private func forgotButtonAction(_ sender: Any) {
        
        self.output.didTriggerForgotButtonAction()
        
    }
    @IBAction private func loginDidEndEditing(_ sender: Any) {
        
        self.output.didTriggerSetLogin(self.loginTextField.text ?? "")
        self.blueButtonValidate()
        
    }
    @IBAction private func passwordDidEndEditing(_ sender: Any) {
        
        self.output.didTriggerSetPassword(self.passwordTextField.text ?? "")
        self.blueButtonValidate()
        
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
}

// MARK: - AuthViewInput
extension AuthViewController: AuthViewInput {
    
    func setupInitialState() {
        
        let is5sAndLess = self.windowService.is5sAndLess
        
        self.topLoginConstraint.constant = is5sAndLess ? 30 : 62
        self.heightConstraint.constant = is5sAndLess ? 30 : 50
        
        self.logoImageView.contentMode = .scaleAspectFit
        
        self.registrationButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
        self.registrationButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        
        self.forgotPasswordButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        self.forgotPasswordButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
        
        self.enterButton.isEnabled = false
        
        self.loginTextField.delegate = self
        self.loginTextField.font = FontProvider.default.textFieldButton
        self.loginTextField.returnKeyType = .next
        
        self.passwordTextField.delegate = self
        self.passwordTextField.returnKeyType = .done
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapEvent)))
    }
    
}

// MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.loginTextField {
            
            self.loginTextField.resignFirstResponder()
            self.output.didTriggerSetLogin(self.loginTextField.text ?? "")
            
            self.passwordTextField.becomeFirstResponder()
            self.blueButtonValidate()
            
        } else if textField == self.passwordTextField {
            
            self.passwordTextField.resignFirstResponder()
            self.blueButtonValidate()
            
        }
        
        return true
    }
    
}

// MARK: - Private
extension AuthViewController {
    
    @objc private func viewTapEvent(gestureRecognizer: UIGestureRecognizer) {
        
        self.loginTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
        self.blueButtonValidate()
        
    }
    
    private func blueButtonValidate() {
        
        self.enterButton.isEnabled = self.loginTextField.text != nil && self.loginTextField.text != ""  && self.passwordTextField.text != nil && self.passwordTextField.text != ""
        
    }
    
    private func clearScreen () {
        
        self.loginTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
        self.loginTextField.text = nil
        self.passwordTextField.text = nil
        self.passwordTextField.isSecureTextEntry = true
        self.blueButtonValidate()
        
    }
    
}
