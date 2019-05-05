import UIKit

final class RestorePasswordViewController: LocalizedViewController {
    var output: RestorePasswordViewOutput!
    var windowService: WindowServiceInterface!
    var notificationService: NotificationServiceInterface!
    
    @IBOutlet weak private var logoImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var loginTextField: UITextField!
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
        
        self.titleLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("restore_password_title_string")
        self.descriptionLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("restore_password_description_string")
        self.loginTextField.placeholder = AppDelegate.serviceProvider.makeStringService().localizeById("restore_password_login_placeholder_string")
        
        self.restoreButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("restore_password_restore_button_string"), for: .normal)
        self.cancelButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("restore_password_cancel_button_string"), for: .normal)
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
    
    @IBAction private func restoreButtonAction(_ sender: Any) {
        
        self.loginTextField.resignFirstResponder()
        
        self.output.didTriggerRestoreButtonWithLogin(self.loginTextField.text ?? "")
    
    }
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        
        self.loginTextField.resignFirstResponder()
        
        self.output.didTriggerCancelButton()
        
    }
}

// MARK: - RestorePasswordViewInput
extension RestorePasswordViewController: RestorePasswordViewInput {
    
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
        
        self.loginTextField.font = FontProvider.default.textFieldButton
        self.loginTextField.textAlignment = .center
        self.loginTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        self.cancelButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
        self.cancelButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapEvent)))
        
        self.restoreButton.isEnabled = false
        
        self.notificationService.addObserver(self, selector: #selector(keyboardAppearEvent), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
}

// MARK: - Private
extension RestorePasswordViewController {
    
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
        
        self.loginTextField.resignFirstResponder()
        self.blueButtonValidate()
        
    }
    
    private func blueButtonValidate() {
        
        self.restoreButton.isEnabled = (self.loginTextField.text?.count ?? 0) > 0
        
    }
    
     private func clearScreen () {

        self.loginTextField.text = nil
        self.restoreButton.isEnabled = false
        
        self.loginTextField.resignFirstResponder()
        
    }

}
