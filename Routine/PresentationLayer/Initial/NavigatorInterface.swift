import UIKit

enum MessageType {
    case success
    case error
    case warning
}

protocol ModalObtainer: class {
    func containerForModal() -> ModalContainer?
}

extension ModalObtainer where Self: UIViewController {
    func containerForModal() -> ModalContainer? {
        guard let view = self.view else { return nil }
        return ModalContainer(view: view, viewController: self)
    }
}

protocol NavigationBarConfiguration: class {
    func configureTransparentNavigationBar()
    func configureNavigationBarWithColor(_ color: UIColor)
    
    func emptyCustomBarLeftButtonAction()
    func customBarLeftButtonAction(icon: UIImage, target: Any, action: Selector)
    func customBarRightButtonAction(icon: UIImage, target: Any, action: Selector)
    func customBarLeftTextButtonAction(text: String, target: Any, action: Selector)
    func customBarRightTextButtonAction(text: String, target: Any, action: Selector)
    
    func configureNavigationTitle(_ title: String)
}

extension NavigationBarConfiguration {
    
    func emptyCustomBarLeftButtonAction() {
        if self.windowService.userInterfaceIdiom != .pad {
            AppDelegate.serviceProvider.makeModuleService().navigation?.hideMenu()
        }
        let emptyLeftBarButtonCustom = UIButton(type: .custom)
        emptyLeftBarButtonCustom.isUserInteractionEnabled = false
        emptyLeftBarButtonCustom.alpha = 0.0
        emptyLeftBarButtonCustom.isHidden = true
        self.currentViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: emptyLeftBarButtonCustom)
    }
    
    func customBarLeftButtonAction(icon: UIImage, target: Any, action: Selector) {
        if self.windowService.userInterfaceIdiom == .pad {
            self.emptyCustomBarLeftButtonAction()
            self.moduleService.navigation?.openMenu()
        } else {
            let leftBarButtonCustom = UIButton(type: .custom)
            leftBarButtonCustom.backgroundColor = ColorProvider.default.clearColor
            leftBarButtonCustom.frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
            leftBarButtonCustom.setImage(icon, for: .normal)
            leftBarButtonCustom.addTarget(target, action: action, for: .touchDown)
            self.currentViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonCustom)
        }
    }
    
    func customBarRightButtonAction(icon: UIImage, target: Any, action: Selector) {
        let rightBarButtonCustom = UIButton(type: .custom)
        rightBarButtonCustom.backgroundColor = ColorProvider.default.clearColor
        rightBarButtonCustom.frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
        rightBarButtonCustom.setImage(icon, for: .normal)
        rightBarButtonCustom.addTarget(target, action: action, for: .touchDown)
        self.currentViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonCustom)
    }
    
    func customBarLeftTextButtonAction(text: String, target: Any, action: Selector) {
        if self.windowService.userInterfaceIdiom == .pad {
            self.emptyCustomBarLeftButtonAction()
            self.moduleService.navigation?.openMenu()
        } else {
            let leftBarButtonCustom = UIButton(type: .custom)
            leftBarButtonCustom.setTitle(text, for: .normal)
            leftBarButtonCustom.backgroundColor = ColorProvider.default.clearColor
            leftBarButtonCustom.frame = CGRect(x: 0.0, y: 0.0, width: leftBarButtonCustom.intrinsicContentSize.width, height: 32.0)
            leftBarButtonCustom.addTarget(target, action: action, for: .touchUpInside)
            self.currentViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonCustom)
        }
    }
    
    func customBarRightTextButtonAction(text: String, target: Any, action: Selector) {
        let rightBarButtonCustom = UIButton(type: .custom)
        rightBarButtonCustom.setTitle(text, for: .normal)
        rightBarButtonCustom.backgroundColor = ColorProvider.default.clearColor
        rightBarButtonCustom.frame = CGRect(x: 0.0, y: 0.0, width: rightBarButtonCustom.intrinsicContentSize.width, height: 32.0)
        rightBarButtonCustom.addTarget(target, action: action, for: .touchUpInside)
        self.currentViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonCustom)
    }
    
    func configureTransparentNavigationBar() {
        self.navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController.navigationBar.shadowImage = UIImage()
        self.navigationController.navigationBar.isTranslucent = true
        self.navigationController.navigationBar.barTintColor = UIColor.clear
    }
    
    func configureNavigationBarWithColor(_ color: UIColor) {
        self.navigationController.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController.navigationBar.shadowImage = nil
        self.navigationController.navigationBar.isTranslucent = false
        self.navigationController.navigationBar.barTintColor = color
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func configureNavigationTitle(_ title: String) {
        self.currentViewController?.navigationItem.title = title
    }
    
}

protocol MenuConfiguration: class {
    func triggerMenu()
    func openMenu()
    func hideMenu()
}

extension MenuConfiguration {
    
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
            
            menuModuleViewController.view.frame = CGRect(x: 0, y: 0, width: self.kMenuViewWidth, height: self.view.frame.height)
            
            self.navigationController.view.frame = CGRect(x: self.kMenuViewWidth, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            // FIXME: - wtf
            menuModuleViewController.viewWillAppear(false)
            
            self.view.setNeedsLayout()
        }, completion: nil)
    }
    
    func hideMenu() {
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            guard let menuModuleViewController = self.menuModuleViewController else { return }
            
            menuModuleViewController.view.frame = CGRect(x: -self.kMenuViewWidth, y: 0, width: self.kMenuViewWidth, height: self.view.frame.height)
            self.navigationController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            self.view.setNeedsLayout()
        }, completion: nil)
    }
    
}

protocol MessageConfiguration: class {

    var navigationController: UINavigationController { get }
    var currentViewController: UIViewController? { get }
    
    var errorLabel: StandartOffsetLabel! { get set }
    var errorImageView: UIImageView! { get set }
    var taskHideError: DispatchWorkItem! { get set }
    
    var window: UIWindow { get }
    
    var view: UIView { get }
    
    // MARK: - Constants
    var textOffset: CGFloat { get set }
    var iconHeight: CGFloat { get set }
    var leftOffset: CGFloat { get set }
    
    var statusHeight: CGFloat { get }
    var navHeight: CGFloat { get }
    var statusNavHeight: CGFloat { get }
    
    func showMessageWithText(_ text: String, andType type: MessageType)
    func showMessageWithText(_ text: String, andType type: MessageType, sender: Any?)
    
    func hideMessages()

}

extension MessageConfiguration {
    
    var currentViewController: UIViewController? { return self.navigationController.viewControllers.last }
    
    var view: UIView { return self.navigationController.view }
    
    var statusHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }
    var navHeight: CGFloat { return self.navigationController.navigationBar.frame.height }
    var statusNavHeight: CGFloat { return self.statusHeight + self.navHeight }
    
    func showMessageWithText(_ text: String, andType type: MessageType) {
        self.showMessageWithText(text, andType: type, sender: nil)
    }
    
    func showMessageWithText(_ text: String, andType type: MessageType, sender: Any? = nil) {
        if let senderViewController = sender as? UIViewController, self.currentViewController != senderViewController {
            return
        }
        
        let errorLabel = StandartOffsetLabel()
        errorLabel.numberOfLines = 0
        errorLabel.font = FontProvider.default.informationMessage
        errorLabel.alpha = 0.0
        errorLabel.edgeInsets = UIEdgeInsets(top: self.statusHeight + self.textOffset, left: self.leftOffset, bottom: self.textOffset, right: self.textOffset)
        errorLabel.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: self.errorLabel.frame.height)
        errorLabel.text = text
        
        self.navigationController.view.addSubview(errorLabel)
        self.errorLabel = errorLabel
        
        let errorImageView = UIImageView()
        errorLabel.addSubview(errorImageView)
        self.errorImageView = errorImageView
        
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
        
        let width = Double(window.frame.width - self.leftOffset - self.textOffset)
        let height = FontProvider.default.informationMessage.sizeOfString(string: text, constrainedToWidth: width).height + (self.textOffset * 2) + 5
        self.errorImageView.frame = CGRect(x: self.textOffset, y: height/2 - self.iconHeight/2 + self.statusHeight, width: self.iconHeight, height: self.iconHeight)
        self.errorImageView.contentMode = .scaleAspectFit
        if #available(iOS 11.0, *) {
            self.errorImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let width = Double(self.window.frame.width - self.leftOffset - self.textOffset)
            let height = FontProvider.default.informationMessage.sizeOfString(string: text, constrainedToWidth: width).height + (self.textOffset * 2) + 5
            self.errorLabel.frame = CGRect(x: 0, y: 0, width: self.window.frame.width, height: height + self.statusHeight)
            self.errorLabel.alpha = 1.0
        })
        
        self.taskHideError?.cancel()
        self.taskHideError = DispatchWorkItem {
            if !self.taskHideError.isCancelled {
                self.hideMessages()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.taskHideError)
        self.errorLabel.isUserInteractionEnabled = true
    }
    
    func hideMessages() {
        let window: UIWindow = UIApplication.shared.delegate!.window!!
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.errorLabel.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: 0)
            self.errorImageView.removeFromSuperview()
            self.errorImageView = nil
        }, completion: nil)
    }
    
}

protocol NavigationConfiguration:
ModalObtainer,
NavigationBarConfiguration,
MenuConfiguration,
MessageConfiguration {
    
}
