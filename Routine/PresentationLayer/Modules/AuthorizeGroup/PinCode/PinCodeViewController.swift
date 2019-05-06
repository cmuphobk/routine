import UIKit

import PinCodeTextField

final class PinCodeViewController: RoutineViewController {
    var output: PinCodeViewOutput!
    var windowService: WindowServiceInterface!
    var notificationService: NotificationServiceInterface!
    
    private var login: String!
    
    @IBOutlet weak private var topLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var pinCodeTextField: PinCodeTextField!
    @IBOutlet weak private var acceptButton: StandartAcceptButton!
    @IBOutlet weak private var resendCodeButton: UIButton!
    @IBOutlet weak private var cancelButton: UIButton!
    
    @IBOutlet weak private var heightAcceptConstraint: NSLayoutConstraint!
    
    weak private var modalView: StandartModalView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.didTriggerViewReadyEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let is5sAndLess = self.windowService.is5sAndLess
        
        output.didTriggerViewWillAppear()
        
        self.pinCodeTextField.font = is5sAndLess ? FontProvider.pinCodeFonts.textFieldSmall : FontProvider.pinCodeFonts.textField
        self.pinCodeTextField.textColor = ColorProvider.default.blackColor
        self.pinCodeTextField.characterLimit = 4
        self.pinCodeTextField.underlineColor = ColorProvider.default.lightGrayColor
        self.pinCodeTextField.underlineWidth = 60.0
        self.pinCodeTextField.underlineHeight = 1.0
        self.pinCodeTextField.underlineHSpacing = 10.0
        self.pinCodeTextField.keyboardType = .numberPad
        self.pinCodeTextField.layoutIfNeeded()
        
        self.navigationController?.configureTransparentNavigationBar()
        self.emptyCustomBarLeftButtonAction()
        
        self.clearScreen()
    }
    
    override func localizationSetup() {
        super.localizationSetup()
        self.navigationItem.title = nil
        
        self.topLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("pin_top_string")
        self.descriptionLabel.text = String(format: AppDelegate.serviceProvider.makeStringService().localizeById("pin_desc_string"), self.login)
        self.acceptButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("pin_accept_string"), for: .normal)
        self.resendCodeButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("pin_resend_string"), for: .normal)
        self.cancelButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("pin_cancel_string"), for: .normal)
    }
    
    @IBAction private func sendPinCodeButtonAction(_ sender: Any) {
        
        self.output.didTriggerEnterPinCode(self.pinCodeTextField.text)
        self.pinCodeTextField.text = nil
        self.blueButtonValidate()
        
    }
    
    @IBAction func resendCodeButtonAction(_ sender: Any) {
        self.output.didTriggerResendButton()
    }
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        
        self.output.didTriggerCancelButton()
        
    }
}

// MARK: - PinCodeViewInput
extension PinCodeViewController: PinCodeViewInput {
    
    func setupInitialState() {
        
        let is5sAndLess = self.windowService.is5sAndLess
        
        self.heightAcceptConstraint.constant = is5sAndLess ? 35 : 55
        
        self.topLabel.textAlignment = .center
        self.topLabel.font = is5sAndLess ? FontProvider.pinCodeFonts.topSmallLabel : FontProvider.pinCodeFonts.topLabel
        
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.font = is5sAndLess ? FontProvider.pinCodeFonts.descriptionTopSmallLabel : FontProvider.pinCodeFonts.descriptionTopLabel
        self.descriptionLabel.numberOfLines = 0
        
        self.resendCodeButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
        self.resendCodeButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        
        self.cancelButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
        self.cancelButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
        
        self.notificationService.addObserver(self, selector: #selector(keyboardAppearEvent), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
    }
    
    func openModal(view: UIView, completion: @escaping (Bool, StandartModalView) -> Void) {
        
        if self.modalView == nil {
            let modalView = StandartModalView()
            modalView.delegate = self
            
            modalView.frame = CGRect.zero
            
            self.modalView = modalView
            
            if !self.modalView.isDescendant(of: view) {
                view.addSubview(self.modalView)
                self.modalView.layoutIfNeeded()
            }
        }
        
        self.showModalAnimate(self.modalView, toFrame: view.frame) { [unowned self] (isCompletion) in
            completion(isCompletion, self.modalView)
        }
        
        
    }
    
    func closeModal(completion: @escaping (Bool) -> Void) {
        
        self.closeModalAnimate(self.modalView) { (isCompletion) in
            completion(isCompletion)
        }
        
    }
    
    func configureWithLogin(_ login: String) {
        
        self.login = login
    
    }
    
}

// MARK: - StandartModalViewDelegate
extension PinCodeViewController: StandartModalViewDelegate {
    
    func didTriggerCloseModalAction(modal: StandartModalView) {
        
        self.closeModalAnimate(self.modalView) { [unowned self] _ in
            self.output.didTriggerCloseModalFromBlurredBackground()
        }
        
    }
    
}

// MARK: - Private
extension PinCodeViewController {
    
    private func showModalAnimate(_ modal: StandartModalView, toFrame: CGRect, completion: @escaping (Bool) -> Void) {
        
        modal.center = CGPoint(x: toFrame.width/2, y: toFrame.height/2)
        for element in modal.modalContainer.subviews {
            element.alpha = 0.0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
            
            modal.bounds = toFrame
            modal.setNeedsLayout()
            
        }, completion: { (isCompletion) in
            
            for element in modal.modalContainer.subviews {
                element.alpha = 1.0
            }
            
            completion(isCompletion)
            
        })
        
    }
    
    private func closeModalAnimate(_ modal: StandartModalView, completion: @escaping (Bool) -> Void) {
        
        for element in modal.modalContainer.subviews {
            element.alpha = 0.0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            
            modal.bounds = CGRect.zero
            modal.setNeedsLayout()
            
        }, completion: { (isCompletion) in
            
            completion(isCompletion)
            
        })
        
    }
    
    @objc private func keyboardAppearEvent(notification: NSNotification) {
        
        self.blueButtonValidate()
        
    }
    
    private func blueButtonValidate() {
        
        self.acceptButton.isEnabled = (self.pinCodeTextField.text?.count ?? 0) >= 4
        
    }

    private func clearScreen() {
        
        self.pinCodeTextField.resignFirstResponder()
        
        self.pinCodeTextField.text = nil
        self.blueButtonValidate()
        
    }

}
