
import UIKit

protocol ErrorCodeViewControllerDelegate: class {
    func didTriggerErrorCodeAcceptButton()
    func didTriggerErrorCodeCancelButton()
}

final class ErrorCodeViewController: LocalizedViewController {
    
    var windowService: WindowServiceInterface!
    
    weak var delegate: ErrorCodeViewControllerDelegate?
    
    @IBOutlet weak private var errorLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var acceptButton: StandartAcceptButton!
    @IBOutlet weak private var cancelButton: UIButton!
    
    @IBOutlet weak private var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var trailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Initial State
        
        //FIXME: create assembly and inject
        self.windowService = AppDelegate.serviceProvider.makeWindowService()
        
        let is5sAndLess = self.windowService.is5sAndLess
        
        self.heightConstraint.constant = is5sAndLess ? 35 : 55
        
        self.leadingConstraint.constant = is5sAndLess ? 32 : 52
        self.trailingConstraint.constant = is5sAndLess ? 32 : 52
        
        self.errorLabel.textAlignment = .center
        self.errorLabel.font = is5sAndLess ? FontProvider.errorCodeFonts.smallTitleLabel : FontProvider.errorCodeFonts.titleLabel
        
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.font = is5sAndLess ? FontProvider.errorCodeFonts.descriptionSmallLabel : FontProvider.errorCodeFonts.descriptionLabel
        self.descriptionLabel.numberOfLines = 0
        
        self.cancelButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
        self.cancelButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        
        self.acceptButton.titleLabel?.font = is5sAndLess ? FontProvider.default.blueSmallButton : FontProvider.default.blueButton
    }
    
    override func localizationSetup() {
        
        self.errorLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("error_code_top_string")
        self.descriptionLabel.text = AppDelegate.serviceProvider.makeStringService().localizeById("error_code_desc_string")
        self.acceptButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("error_code_accept_string"), for: .normal)
        self.cancelButton.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById("error_code_cancel_string"), for: .normal)
        
    }
    @IBAction private func acceptuButtonAction(_ sender: Any) {
        self.delegate?.didTriggerErrorCodeAcceptButton()
    }
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        self.delegate?.didTriggerErrorCodeCancelButton()
    }
}
