import UIKit
import Stevia

class InputTextPopupViewController: RoutineViewController, BaseView {    
    var output: ConfirmationViewOutput!
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    weak private var acceptButton: StandartAcceptButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    var is5sAndLess: Bool!
    
    override func loadView() {
        super.loadView()
        
        let acceptButton = StandartAcceptButton()
        acceptButton.addTarget(self, action: #selector(acceptButtonAction), for: .touchDown)
        self.cancelButton.superview?.sv(acceptButton)
        
        align(lefts: self.textLabel, acceptButton)
        align(rights: self.textLabel, acceptButton)
        
        acceptButton.Bottom == self.cancelButton.Top
        
        acceptButton.Height == self.cancelButton.Height
        
        self.acceptButton = acceptButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapEvent)))

        self.textField.delegate = self
        
        self.output?.didTriggerViewReadyEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.output?.didTriggerViewWillAppear()
    }
    
    // MARK: - Actions
    @objc private func acceptButtonAction(_ sender: Any) {
        self.output?.acceptButtonDidPressed()
    }
    
    @IBAction private func cancelButonAction(_ sender: Any) {
        self.output?.cancelButtonDidPressed()
    }
    
    // MARK: - Private
    @objc private func viewTapEvent(gestureRecognizer: UIGestureRecognizer) {
        self.textField.resignFirstResponder()
    }
    
    @IBAction func textFieldValueChangedAction(_ sender: UITextField) {
        self.output?.textFieldValueChanged(newValue: sender.text ?? "")
    }
}

// MARK: - ConfirmationModuleInput
extension InputTextPopupViewController: ConfirmationViewInput {
    func setupInitialState() {
        
        self.is5sAndLess = self.output?.windowService.is5sAndLess
        
        self.acceptButton.height(self.is5sAndLess ? 35 : 55)
        self.leadingConstraint.constant = self.is5sAndLess ? 32 : 52
        self.trailingConstraint.constant = self.is5sAndLess ? 32 : 52
        
        self.textField.keyboardType = .default
        self.textField.returnKeyType = .done
    }
    
    func updateCaptionText(_ text: String) {
        self.captionLabel.textAlignment = .center
        self.captionLabel.font = is5sAndLess ? FontProvider.errorCodeFonts.smallTitleLabel : FontProvider.errorCodeFonts.titleLabel
        self.captionLabel.textColor = ColorProvider.confirmationModuleColors.captionText
        
        self.captionLabel.text = text
    }
    
    func updateText(_ text: String) {
        self.textLabel.textAlignment = .center
        self.textLabel.font = is5sAndLess ? FontProvider.errorCodeFonts.descriptionSmallLabel : FontProvider.errorCodeFonts.descriptionLabel
        self.textLabel.textColor = ColorProvider.confirmationModuleColors.text
        self.textLabel.numberOfLines = 0
        
        self.textLabel.text = text
    }
    
    func updateTextFieldValue(_ value: String, placeholder: String) {
        self.textField.textAlignment = .center
        self.textField.font = FontProvider.default.textFieldButton
        self.textField.textColor = ColorProvider.confirmationModuleColors.textField
        self.textField.text = value
        self.textField.placeholder = placeholder
        self.textField.autocapitalizationType = .sentences
        
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

// MARK: - UITextFieldDelegate
extension InputTextPopupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
