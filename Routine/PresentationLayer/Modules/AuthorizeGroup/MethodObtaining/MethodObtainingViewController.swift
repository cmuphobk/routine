import UIKit

final class MethodObtainingViewController: RoutineViewController {
    var output: MethodObtainingViewOutput!
    var windowService: WindowServiceInterface!
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var phoneButton: StandartCheckBoxButton!
    @IBOutlet weak private var emailButton: StandartCheckBoxButton!
    @IBOutlet weak private var blueButton: StandartAcceptButton!
    @IBOutlet weak private var cancelButton: UIButton!
    
    @IBOutlet weak private var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var bottomCancelConstraint: NSLayoutConstraint!
    
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
        
        self.titleLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("method_obataining_title_string")
        self.descriptionLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("method_obataining_description_string")
        
        self.blueButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("method_obataining_enter_string"), for: .normal)
        self.cancelButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("method_obataining_cancel_string"), for: .normal)
        
    }
    @IBAction private func chooseButtonAction(_ sender: StandartCheckBoxButton) {
        
        self.phoneButton.isChecked = sender == self.phoneButton
        self.emailButton.isChecked = sender == self.emailButton
        
        self.blueButtonValidate()
        
    }
    @IBAction private func enterButtonAction(_ sender: Any) {
        
        if self.phoneButton.isChecked {
            
            self.output.didTriggerEnterButtonWithLogin(self.phoneButton.titleLabel?.text ?? "")
            
        } else if self.emailButton.isChecked {
            
            self.output.didTriggerEnterButtonWithLogin(self.emailButton.titleLabel?.text ?? "")
            
        }
        
    }
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        
        self.output.didTriggerCancelButton()
        
    }
}

// MARK: - MethodObtainingViewInput
extension MethodObtainingViewController: MethodObtainingViewInput {
    
    func setupInitialState() {

        let is5sAndLess = self.windowService.is5sAndLess
        
        self.heightConstraint.constant = is5sAndLess ? 30 : 50
        
        self.bottomCancelConstraint.constant = is5sAndLess ? 40 : 76
        
        self.titleLabel.font = FontProvider.methodObtainingFonts.titleLabel
        self.titleLabel.numberOfLines = 1
        self.titleLabel.textColor = ColorProvider.default.blackColor
        self.titleLabel.textAlignment = .center
        
        self.descriptionLabel.font = FontProvider.methodObtainingFonts.descriptionLabel
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textColor = ColorProvider.default.blackColor
        self.descriptionLabel.textAlignment = .center
        
        self.cancelButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
        self.cancelButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        
        self.blueButton.isEnabled = false
        
    }
    
    func configureModuleWithNumber(_ number: String, andEmail email: String) {
        
        self.phoneButton.setTitle(number, for: .normal)
        self.emailButton.setTitle(email, for: .normal)
        
    }
    
}

// MARK: - Private
extension MethodObtainingViewController {
    
    private func blueButtonValidate() {
        
        self.blueButton.isEnabled = self.phoneButton.isEnabled || self.emailButton.isEnabled
        
    }
    
    private func clearScreen () {
        
        self.phoneButton.isChecked = false
        self.emailButton.isChecked = false
        self.blueButtonValidate()
        
    }
    
}
