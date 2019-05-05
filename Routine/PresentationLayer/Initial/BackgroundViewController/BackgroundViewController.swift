
import UIKit

enum MessageType {
    case success
    case error
    case warning
}

// MARK: - Properties
final class BackgroundViewController: UIViewController {
    
    private let kMenuViewWidth: CGFloat = 300.0
    
    var moduleService = AppDelegate.serviceProvider.makeModuleService()
    var authService = AppDelegate.serviceProvider.makeAuthService()
    
    var initialNavigationController: UINavigationController!
    var menuModuleViewController: UIViewController!
    var currentViewController: UIViewController?
    var animateLaunchScreenViewController: AnimateLaunchScreenViewController!
    
    var menuModuleInput: MenuModuleInput!
    
    var statusHeight: CGFloat!
    var navHeight: CGFloat!
    var statusNavHeight: CGFloat!
    var modulesStack: [UIViewController] = []
    
    var errorLabel: StandartOffsetLabel!
    var errorImageView: UIImageView!
    
    var taskHideError: DispatchWorkItem!

}

// MARK: - LifeCycle
extension BackgroundViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moduleBeforeLaunchName = self.configureNavigationController()
        
        self.configureMenu()
        
        self.configureAnimationLaunch(moduleBeforeLaunchName: moduleBeforeLaunchName)
        
    }
}

// MARK: - MenuModuleOutput
extension BackgroundViewController: MenuModuleOutput {
    
}

// MARK: - NavigatorInterface
extension BackgroundViewController: NavigatorInterface {
    
    func containerForModal() -> ModalContainer? {
        guard let view = self.view else { return nil }
        return ModalContainer(view: view, viewController: self)
    }
    
    func triggerMenu() {
        guard let menuModuleViewController = self.menuModuleViewController else { return }
        let menuModuleFrame = menuModuleViewController.view.frame
        let menuModuleViewX = menuModuleFrame.origin.x
        
        if menuModuleViewX < 0 {
            self.openMenu()
        } else {
            self.hideMenu()
        }
    }
    
    func openMenu() {
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            guard let menuModuleViewController = self.menuModuleViewController else { return }
            //self.view.bringSubviewToFront(menuModuleViewController.view)
            
            menuModuleViewController.view.frame = CGRect(x: 0, y: 0, width: self.kMenuViewWidth, height: self.view.frame.height)
            
            var initialNavigationControllerWidth = self.view.frame.width
            if UIDevice.current.userInterfaceIdiom == .pad {
                initialNavigationControllerWidth -= self.kMenuViewWidth
            }
            
            self.initialNavigationController.view.frame = CGRect(x: self.kMenuViewWidth, y: 0, width: initialNavigationControllerWidth, height: self.view.frame.height)
            menuModuleViewController.viewWillAppear(false)
            
            self.view.setNeedsLayout()
        }, completion: nil)
    }
    
    func hideMenu() {
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            guard let menuModuleViewController = self.menuModuleViewController else { return }
            
            menuModuleViewController.view.frame = CGRect(x: -self.kMenuViewWidth, y: 0, width: self.kMenuViewWidth, height: self.view.frame.height)
            self.initialNavigationController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            self.view.setNeedsLayout()
        }, completion: nil)
    }
    
    func openModule(_ module: Module) {
        guard let innerViewController = module.viewController else { return }
        
        self.menuModuleInput.selectMenuItemWithName(module.name)
        
        if let navigationController = self.initialNavigationController {
            self.modulesStack = [innerViewController]
            
            navigationController.setViewControllers(self.modulesStack, animated: true)
            self.currentViewController = innerViewController
        }
    }
    
    func openModuleFromLeft(_ module: Module) {
        guard let innerViewController = module.viewController else { return }
        
        self.menuModuleInput.selectMenuItemWithName(module.name)
        
        if let navigationController = self.initialNavigationController {
            self.modulesStack.insert(innerViewController, at: self.modulesStack.count-1)
            
            navigationController.setViewControllers(self.modulesStack, animated: false)
            navigationController.popViewController(animated: true)
            self.currentViewController = innerViewController
            self.modulesStack.removeLast()
        }
    }
    
    func pushModule(_ module: Module) {
        guard let innerViewController = module.viewController else { return }
        
        if let navigationController = self.initialNavigationController {
            self.modulesStack += [innerViewController]
            navigationController.setViewControllers(self.modulesStack, animated: true)
        }
        
        self.currentViewController = innerViewController
    }
    
    func popModule() {
        self.popModule(1)
    }
    
    func popModule(_ countPops: Int) {
        if let navigationController = self.initialNavigationController {
            
            var index = 0
            while index < countPops {
                self.modulesStack.removeLast()
                index += 1
            }
            
            navigationController.setViewControllers(self.modulesStack, animated: true)
        }
        
        self.currentViewController = self.modulesStack.last
    }
    
    func showMessageWithText(_ text: String, andType type: MessageType) {
        self.showMessageWithText(text, andType: type, sender: nil)
    }
    
    func showMessageWithText(_ text: String, andType type: MessageType, sender: Any? = nil) {
        if let senderViewController = sender as? UIViewController, self.currentViewController != senderViewController {
            return
        }
        guard let navigationController = self.initialNavigationController else { return }
        
        let window: UIWindow = UIApplication.shared.delegate!.window!!
        let kOffset: CGFloat = 17.0
        let kIconHeight: CGFloat = 15.0
        let kLeftOffset: CGFloat = 45.0
        
        if self.errorLabel == nil {
            self.errorLabel = StandartOffsetLabel()
            self.errorLabel.numberOfLines = 0
            self.errorLabel.font = FontProvider.default.informationMessage
            self.errorLabel.alpha = 0.0
            self.errorLabel.edgeInsets = UIEdgeInsets(top: self.statusHeight + kOffset, left: kLeftOffset, bottom: kOffset, right: kOffset)
            
            navigationController.view.addSubview(self.errorLabel)
        }
        
        if self.errorImageView == nil {
            self.errorImageView = UIImageView()
            self.errorLabel.addSubview(self.errorImageView)
        }
        
        self.errorLabel.text = text
        
        
        self.errorLabel.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: self.errorLabel.frame.height)
        
        switch type {
        case .success:
            self.errorImageView.image = ImageProvider.default.okIcon.withRenderingMode(.alwaysTemplate)
            self.errorLabel.textColor = ColorProvider.default.whiteColor
            self.errorLabel.backgroundColor = ColorProvider.messageColors.backgroundGreenColor
            self.errorImageView.tintColor = ColorProvider.default.whiteColor
            
        case .error:
            self.errorImageView.image = ImageProvider.default.warnIcon.withRenderingMode(.alwaysTemplate)
            self.errorLabel.textColor = ColorProvider.default.whiteColor
            self.errorLabel.backgroundColor = ColorProvider.messageColors.backgroundRedColor
            self.errorImageView.tintColor = ColorProvider.default.whiteColor
            
        case .warning:
            self.errorImageView.image = ImageProvider.default.warnIcon.withRenderingMode(.alwaysTemplate)
            self.errorLabel.textColor = ColorProvider.default.blackColor
            self.errorLabel.backgroundColor = ColorProvider.messageColors.backgroundYellowColor
            self.errorImageView.tintColor = ColorProvider.default.blackColor
            
        }
        
        let width = Double(window.frame.width - kLeftOffset - kOffset)
        let height = FontProvider.default.informationMessage.sizeOfString(string: text, constrainedToWidth: width).height + (kOffset * 2) + 5
        self.errorImageView.frame = CGRect(x: kOffset, y: height/2 - kIconHeight/2 + self.statusHeight, width: kIconHeight, height: kIconHeight)
        self.errorImageView.contentMode = .scaleAspectFit
        if #available(iOS 11.0, *) {
            self.errorImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            let width = Double(window.frame.width - kLeftOffset - kOffset)
            let height = FontProvider.default.informationMessage.sizeOfString(string: text, constrainedToWidth: width).height + (kOffset * 2) + 5
            self.errorLabel.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: height + self.statusHeight)
            self.errorLabel.alpha = 1.0
            
        })
        
        self.taskHideError?.cancel()
        
        self.taskHideError = DispatchWorkItem {
            if self.taskHideError.isCancelled {
                return
            }
            self.hideMessages()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.taskHideError)
        
        self.errorLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(errorLabelTapEvent)))
        self.errorLabel.isUserInteractionEnabled = true
    }
    
    func hideMessages() {
        
        let window: UIWindow = UIApplication.shared.delegate!.window!!
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            self.errorLabel?.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: 0)
            self.errorImageView?.removeFromSuperview()
            self.errorImageView = nil
            
        }, completion: nil)
        
    }
    
}

// MARK: - Private
extension BackgroundViewController {
    
    private func configureNavigationController() -> String {
        
        guard let moduleBeforeLaunch = self.obtainModuleBeforeLaunch() else { abort() }
        guard let viewControllerBeforeLaunch = moduleBeforeLaunch.viewController else { abort() }
        
        self.initialNavigationController = UINavigationController(rootViewController: viewControllerBeforeLaunch)
        self.initialNavigationController.view.frame = self.view.bounds
        self.view.addSubview(self.initialNavigationController.view)
        self.addChild(self.initialNavigationController)
        
        self.moduleService.navigation = self
        
        self.statusHeight = UIApplication.shared.statusBarFrame.height
        self.navHeight = self.initialNavigationController.navigationBar.frame.height
        self.statusNavHeight = self.statusHeight + self.navHeight
        
        self.modulesStack = [viewControllerBeforeLaunch]
        
        return moduleBeforeLaunch.name
        
    }
    
    private func configureAnimationLaunch(moduleBeforeLaunchName: String) {
        
        self.animateLaunchScreenViewController = R.storyboard.animateLaunchScreenViewController.animateLaunchScreenViewController()
        
        if moduleBeforeLaunchName == kAuthModuleId {
            self.authService.obtainGuestToken { [unowned self] (_) in
                self.updateProgressToValue(0.5)
                self.updateProgress()
            }
        } else {
            self.updateProgressToValue(1.0)
        }
        
        if let viewController = self.animateLaunchScreenViewController {
            guard let view = viewController.view else { return }
            self.addChild(viewController)
            view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.addSubview(view)
            self.updateProgressToValue(0)
        }
        
    }
    
    private func configureMenu() {
        
        self.moduleService.moduleFactory.makeMenuModule(moduleOutput: self) { [unowned self] (viewController: UIViewController?, moduleInput: MenuModuleInput?) in
            
            self.menuModuleInput = moduleInput
            self.menuModuleInput.configureModule(menuItems: self.moduleService.obtainAvailableModulesAndActionsIds())
            
            if let viewController = viewController {
                guard let view = viewController.view else { return }
                self.addChild(viewController)
                view.frame = CGRect(x: -self.kMenuViewWidth, y: 0, width: self.kMenuViewWidth, height: self.view.frame.height)
                self.view.addSubview(view)
                self.menuModuleViewController = viewController
            }
            
        }
        
    }
    
    private func obtainModuleBeforeLaunch() -> Module? {
        
        let moduleId = self.moduleService.obtainModuleIdBeforeLaunch()
        var module: Module?
        
        switch moduleId {
        case kMainModuleId:
            
            self.moduleService.moduleFactory.makeMainModule { (_, mainModuleInput) in
                module = mainModuleInput as? Module
            }
            
        case kAuthModuleId:
            
            self.moduleService.moduleFactory.makeAuthModule { (_, authModuleInput) in
                module = authModuleInput as? Module
            }
            
        default:
            module = nil
        }
        
        return module
    }
    
    private func updateProgressToValue(_ progress: Float) {
        
        self.animateLaunchScreenViewController?.updateProgress(progress)
        
        if self.animateLaunchScreenViewController.progress >= 1.0 {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.animateLaunchScreenViewController.view.alpha = 0.0
            }, completion: { [unowned self] _ in
                self.animateLaunchScreenViewController.view.removeFromSuperview()
                self.animateLaunchScreenViewController.removeFromParent()
            })
            
            return
        }
        
    }
    
    private func updateProgress() {
        
        self.animateLaunchScreenViewController?.updateProgress(self.animateLaunchScreenViewController.progress + 0.15)
        
        if self.animateLaunchScreenViewController.progress >= 1.0 {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.animateLaunchScreenViewController.view.alpha = 0.0
            }, completion: { [unowned self] _ in
                self.animateLaunchScreenViewController.view.removeFromSuperview()
                self.animateLaunchScreenViewController.removeFromParent()
            })
            
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: self.updateProgress)
        
    }
    
    @objc private func errorLabelTapEvent(gestureRecognizer: UIGestureRecognizer) {
        
        self.hideMessages()
        
    }
    
}
