import UIKit

protocol CreateMedicineCourseViewControllerDelegate: class {
    func didTriggerCreateMedicineCourseWithName(_ name: String)
    func didTriggerCancel()
}

final class CreateMedicineCourseViewController: RoutineViewController {
    var windowService: WindowServiceInterface!
    
    weak var delegate: CreateMedicineCourseViewControllerDelegate?
    
    var localizeService: StringServiceInterface!
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var nameTextField: StandartTextField!
    @IBOutlet weak private var acceptButton: StandartAcceptButton!
    @IBOutlet weak private var cancelButton: UIButton!
    
    @IBOutlet weak private var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var trailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.localizeService = AppDelegate.serviceProvider.makeStringService()
        
        self.windowService = AppDelegate.serviceProvider.makeWindowService()
        
        let is5sAndLess = self.windowService.is5sAndLess
        
        self.heightConstraint.constant = is5sAndLess ? 35 : 55
        
        self.leadingConstraint.constant = is5sAndLess ? 32 : 52
        self.trailingConstraint.constant = is5sAndLess ? 32 : 52
        
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = is5sAndLess ? FontProvider.errorCodeFonts.smallTitleLabel : FontProvider.errorCodeFonts.titleLabel
        
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.font = is5sAndLess ? FontProvider.errorCodeFonts.descriptionSmallLabel : FontProvider.errorCodeFonts.descriptionLabel
        self.descriptionLabel.numberOfLines = 0
        
        self.cancelButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
        self.cancelButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        
        self.acceptButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blueSmallButton : FontProvider.default.blueButton
        
        self.nameTextField.delegate = self
        self.nameTextField.font = FontProvider.default.textFieldButton
        self.nameTextField.returnKeyType = .next
        
        self.acceptButton.isEnabled = false
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapEvent)))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.acceptButton.isEnabled = false
    }
    
    override func localizationSetup() {
        
        self.titleLabel.text = self.localizeService.localizeId("create_med_course_top_string")
        self.descriptionLabel.text = self.localizeService.localizeId("create_med_course_desc_string")
        self.acceptButton.setTitle(self.localizeService.localizeId("create_med_course_accept_string"), for: .normal)
        self.cancelButton.setTitle(self.localizeService.localizeId("create_med_course_cancel_string"), for: .normal)
        self.nameTextField.placeholder = self.localizeService.localizeId("create_med_course_name_string")
        
    }
    
    @IBAction private func acceptButtonAction(_ sender: Any) {
        self.delegate?.didTriggerCreateMedicineCourseWithName(self.nameTextField.text ?? "")
    }
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        
        self.delegate?.didTriggerCancel()
        
    }
    
}

extension CreateMedicineCourseViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if self.nameTextField.text != nil && self.nameTextField.text != "" {
            
            self.acceptButton.isEnabled = true
            
        }
        
    }
    
}

extension CreateMedicineCourseViewController {
    
    @objc private func viewTapEvent(gestureRecognizer: UIGestureRecognizer) {
        
        self.nameTextField.resignFirstResponder()
        
    }
    
}
