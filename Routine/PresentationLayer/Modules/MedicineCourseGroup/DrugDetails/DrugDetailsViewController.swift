import UIKit

final class DrugDetailsViewController: RoutineViewController {
    var output: DrugDetailsViewOutput!
    var animator: DrugDetailsAnimator!
    //FIXME: 
    var moduleService: ModuleServiceInterface!
    
    @IBOutlet weak private var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.didTriggerViewReadyEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.didTriggerViewWillAppear()
        
        AppDelegate.serviceProvider.makeModuleService().navigation?.configureNavigationBarWithColor(ColorProvider.default.blueColor)
        AppDelegate.serviceProvider.makeModuleService().navigation?.customBarLeftButtonAction(icon: ImageProvider.default.backArrow.imageWithMask(color: ColorProvider.default.whiteColor), action: #selector(backButtonPressed))
    }
    
    override func localizationSetup() {
        super.localizationSetup()
    }
    
    @objc private func backButtonPressed() {
        self.output.didTriggerBackAction()
    }
    
    @objc private func editDrugAction() {
        self.output.editDrugAction()
    }
}

// MARK: - DrugDetailsViewInput
extension DrugDetailsViewController: DrugDetailsViewInput {
    func setupInitialState() {
        
    }
    
    func updateNavTitle(_ text: String) {
        self.navigationItem.title = text
    }
    
    func enableEditButton() {
        AppDelegate.serviceProvider.makeModuleService().navigation?.customBarRightButtonAction(icon: ImageProvider.drugsDetailsImages.editIcon, action: #selector(editDrugAction))
    }
    
    func updateDetailsInfo(htmlCode: String) {
        self.webView.loadHTMLString(htmlCode, baseURL: nil)
    }
}
