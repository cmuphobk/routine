import UIKit

class CalculatorPopup: UIViewController {
    var presenter: ConfirmationModuleOutput?
    var windowService: WindowServiceInterface!
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    @IBOutlet var calcsButtons: [UIButton]!
    
    var is5sAndLess: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapEvent)))
        //self.textField.clearButtonMode = .whileEditing
        
        self.presenter?.didTriggerViewReadyEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.didTriggerViewWillAppear()
    }
    
    // MARK: - Actions
    @IBAction private func acceptButtonAction(_ sender: Any) {
        self.presenter?.acceptButtonDidPressed()
    }
    
    @IBAction private func cancelButonAction(_ sender: Any) {
        self.presenter?.cancelButtonDidPressed()
    }
    
    // MARK: - Private
    @objc private func viewTapEvent(gestureRecognizer: UIGestureRecognizer) {
        self.textField.resignFirstResponder()
    }
    
    @IBAction func textFieldValueChangedAction(_ sender: UITextField) {
        self.presenter?.textFieldValueChanged(newValue: sender.text ?? "")
    }
    
    @IBAction func digitButtonPressed(_ sender: UIButton) {
        self.presenter?.addToText(sender.currentTitle ?? "")
    }
    
    @IBAction func backspaceButtonPressed(_ sender: Any) {
        self.presenter?.removeAtEnd()
    }
}

// MARK: - ConfirmationModuleInput
extension CalculatorPopup: ConfirmationModuleInput {
    func setupInitialState() {
        
        self.windowService = AppDelegate.serviceProvider.makeWindowService()
        
        self.is5sAndLess = self.windowService.is5sAndLess
        
        self.heightConstraint.constant = self.is5sAndLess ? 35 : 55
        self.leadingConstraint.constant = self.is5sAndLess ? 32 : 52
        self.trailingConstraint.constant = self.is5sAndLess ? 32 : 52
    }
    
    func updateCaptionText(_ text: String) {
        self.captionLabel.textAlignment = .center
        self.captionLabel.font = is5sAndLess ? FontProvider.errorCodeFonts.smallTitleLabel : FontProvider.errorCodeFonts.titleLabel
        self.captionLabel.textColor = ColorProvider.confirmationModuleColors.captionText
        
        self.captionLabel.text = text
    }
    
    func updateText(_ text: String) {
        // empty
    }
    
    func updateTextFieldValue(_ value: String, placeholder: String) {
        self.textField.textAlignment = .center
        self.textField.font = FontProvider.default.textFieldButton
        self.textField.textColor = ColorProvider.confirmationModuleColors.textField
        self.textField.text = value
        self.textField.placeholder = placeholder
        
        self.textField.returnKeyType = .next
    }
    
    func updateAcceptButtonText(_ text: String) {
        self.acceptButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blueSmallButton : FontProvider.default.blueButton
        self.acceptButton.setTitle(text, for: .normal)
    }
    
    func updateCancelButtonText(_ text: String) {
        self.cancelButton.setTitleColor(ColorProvider.confirmationModuleColors.cancelButton, for: .normal)
        self.cancelButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        self.cancelButton.setTitle(text, for: .normal)
    }
    
    func updateAcceptButtonAvilable(_ avilable: Bool) {
        self.acceptButton.isEnabled = avilable
    }
}
