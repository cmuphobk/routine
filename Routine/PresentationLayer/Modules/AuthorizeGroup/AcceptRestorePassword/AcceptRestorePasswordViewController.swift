import UIKit

final class AcceptRestorePasswordViewController: RoutineViewController {
    var output: AcceptRestorePasswordViewOutput!
    var windowService: WindowServiceInterface!
    var notificationService: NotificationServiceInterface!
    
    @IBOutlet weak private var logoImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var passwordTextField: StandartPasswordTextField!
    @IBOutlet weak private var paswordRepeatTextField: StandartPasswordTextField!
    @IBOutlet weak private var restoreButton: StandartAcceptButton!
    @IBOutlet weak private var cancelButton: UIButton!
    
    @IBOutlet weak private var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var bottomConstraint: NSLayoutConstraint!
    
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
        
        self.logoImageView.image = ImageProvider.profileImages.logoIcon
        
        self.titleLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("accept_restore_password_title_string")
        self.descriptionLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("accept_restore_password_description_string")
        self.passwordTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("accept_restore_password_placeholder_string")
        self.paswordRepeatTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("accept_restore_password_repeat_placeholder_string")
        
        self.restoreButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("accept_restore_password_restore_button_string"), for: .normal)
        self.cancelButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("accept_restore_password_cancel_button_string"), for: .normal)
    }
    
    @IBAction private func restoreButtonAction(_ sender: Any) {
        self.paswordRepeatTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.output.didTriggerRestoreButton(password: self.passwordTextField.text ?? "")
    }
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        self.paswordRepeatTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.output.didTriggerCancelButton()
    }
    
}

// MARK: - AcceptRestorePasswordViewInput
extension AcceptRestorePasswordViewController: AcceptRestorePasswordViewInput {
    
    func setupInitialState() {
        
        let is5sAndLess = self.windowService.is5sAndLess
        
        self.heightConstraint.constant = is5sAndLess ? 30 : 50
        self.bottomConstraint.constant = is5sAndLess ? 40 : 76
        
        self.logoImageView.contentMode = .scaleAspectFit
        
        self.titleLabel.font = is5sAndLess ? FontProvider.restorePasswordFonts.smallTitleLabel : FontProvider.restorePasswordFonts.titleLabel
        self.titleLabel.numberOfLines = 1
        self.titleLabel.textColor = ColorProvider.default.blackColor
        self.titleLabel.textAlignment = .center
        
        self.descriptionLabel.font = is5sAndLess ? FontProvider.restorePasswordFonts.descriptionSmallLabel : FontProvider.restorePasswordFonts.descriptionLabel
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textColor = ColorProvider.default.blackColor
        self.descriptionLabel.textAlignment = .center
        
        self.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.passwordTextField.delegate = self
        
        self.paswordRepeatTextField.isMainField = false
        self.paswordRepeatTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.paswordRepeatTextField.delegate = self
        
        self.cancelButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
        self.cancelButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapEvent)))
        
        self.restoreButton.isEnabled = false
        
        self.notificationService.addObserver(self, selector: #selector(keyboardAppearEvent), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

    }
    
}

// MARK: - UITextFieldDelegate
extension AcceptRestorePasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.passwordTextField {
            self.passwordTextField.resignFirstResponder()
            self.paswordRepeatTextField.becomeFirstResponder()
        } else if textField == self.paswordRepeatTextField {
            self.paswordRepeatTextField.resignFirstResponder()
        }
        return true
    }
    
}

// MARK: - Private
extension AcceptRestorePasswordViewController {
    
    @objc private func keyboardAppearEvent(notification: NSNotification) {
        
        let is5sAndLess = self.windowService.is5sAndLess
        
        if is5sAndLess {
            
            guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardFrame: CGRect = keyboardFrameValue.cgRectValue
            
            UIView.animate(withDuration: 0.1, animations: { [unowned self] () -> Void in
                if self.view.frame.origin.y < 0 {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: -keyboardFrame.size.height, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            })
        }
        
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        
        self.blueButtonValidate()
        
    }
    
    @objc private func viewTapEvent(gestureRecognizer: UIGestureRecognizer) {
        
        self.passwordTextField.resignFirstResponder()
        self.paswordRepeatTextField.resignFirstResponder()
        
        self.blueButtonValidate()
        
    }
    
    private func blueButtonValidate() {
        
        if self.paswordRepeatTextField.text != nil && self.paswordRepeatTextField.text != "" {
            self.paswordRepeatTextField.isOk = self.passwordTextField.text == self.paswordRepeatTextField.text
        } else {
            self.paswordRepeatTextField.isOk = nil
        }
        
        self.restoreButton.isEnabled = self.passwordTextField.text != nil && self.passwordTextField.text != "" && self.paswordRepeatTextField.text != nil && self.paswordRepeatTextField.text != "" && self.passwordTextField.text == self.paswordRepeatTextField.text
        
    }
    
    private func clearScreen () {
        
        self.paswordRepeatTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
        self.passwordTextField.text = nil
        self.passwordTextField.isSecureTextEntry = true
        
        self.paswordRepeatTextField.text = nil
        self.restoreButton.isEnabled = false
        
    }
    
}
