import UIKit

enum MessageType {
    case success
    case error
    case warning
}

struct ModalContainer {
    var view: UIView
    var viewController: UIViewController
}

// MARK: - NavigationContainer

protocol NavigationContainer: class {
    // MARK: - required
    
    var navigationController: UINavigationController { get }
    
    // MARK: - optional
    
    var currentViewController: UIViewController? { get }
    var view: UIView { get }
    
    var statusHeight: CGFloat { get }
    var navHeight: CGFloat { get }
    var statusNavHeight: CGFloat { get }
}

extension NavigationContainer {
    var currentViewController: UIViewController? { return self.navigationController.viewControllers.last }
    
    var view: UIView { return self.navigationController.view }
    
    var statusHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }
    var navHeight: CGFloat { return self.navigationController.navigationBar.frame.height }
    var statusNavHeight: CGFloat { return self.statusHeight + self.navHeight }
}

// MARK: - ModalObtainer

protocol ModalObtainer: class {
    // MARK: - methods
    
    func containerForModal() -> ModalContainer?
}

extension ModalObtainer where Self: UIViewController {
    func containerForModal() -> ModalContainer? {
        guard let view = self.view else { return nil }
        return ModalContainer(view: view, viewController: self)
    }
}

extension ModalObtainer where Self: NavigationContainer {
    func containerForModal() -> ModalContainer? {
        guard let view = self.navigationController.view else { return nil }
        return ModalContainer(view: view, viewController: self.navigationController)
    }
}

// MARK: - NavigationBarConfiguration

protocol IdiomCheckerDelegate: class {
    var userInterfaceIdiom: UIUserInterfaceIdiom { get }
}

protocol NavigationBarConfiguration: NavigationContainer {
    // MARK: - optional
    
    var idiomCheckerDelegate: IdiomCheckerDelegate? { get set }
    var menuConfiguration: MenuConfiguration? { get set }
    
    // MARK: - methods
    
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
        if let idiomCheckerDelegate = self.idiomCheckerDelegate, idiomCheckerDelegate.userInterfaceIdiom != .pad {
            self.menuConfiguration?.hideMenu()
        }
        let emptyLeftBarButtonCustom = UIButton(type: .custom)
        emptyLeftBarButtonCustom.isUserInteractionEnabled = false
        emptyLeftBarButtonCustom.alpha = 0.0
        emptyLeftBarButtonCustom.isHidden = true
        self.currentViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: emptyLeftBarButtonCustom)
    }
    
    func customBarLeftButtonAction(icon: UIImage, target: Any, action: Selector) {
        if let idiomCheckerDelegate = self.idiomCheckerDelegate {
            if idiomCheckerDelegate.userInterfaceIdiom == .pad {
                self.emptyCustomBarLeftButtonAction()
                self.menuConfiguration?.openMenu()
            } else {
                let leftBarButtonCustom = UIButton(type: .custom)
                leftBarButtonCustom.backgroundColor = ColorProvider.default.clearColor
                leftBarButtonCustom.frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
                leftBarButtonCustom.setImage(icon, for: .normal)
                leftBarButtonCustom.addTarget(target, action: action, for: .touchDown)
                self.currentViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonCustom)
            }
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
        if let idiomCheckerDelegate = self.idiomCheckerDelegate {
            if idiomCheckerDelegate.userInterfaceIdiom == .pad {
                self.emptyCustomBarLeftButtonAction()
                self.menuConfiguration?.openMenu()
            } else {
                let leftBarButtonCustom = UIButton(type: .custom)
                leftBarButtonCustom.setTitle(text, for: .normal)
                leftBarButtonCustom.backgroundColor = ColorProvider.default.clearColor
                leftBarButtonCustom.frame = CGRect(x: 0.0, y: 0.0, width: leftBarButtonCustom.intrinsicContentSize.width, height: 32.0)
                leftBarButtonCustom.addTarget(target, action: action, for: .touchUpInside)
                self.currentViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonCustom)
            }
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

// MARK: - MenuConfiguration

protocol MenuConfiguration: NavigationContainer {
    
    // MARK: - methods
    
    func triggerMenu()
    func hideMenu()
    func openMenu()
}

protocol MessageConfigurationDelegate: class {
    func obtainMessageWidth() -> CGFloat
    func obtainTextOffset() -> CGFloat
    func obtainIconHeight() -> CGFloat
    func obtainLeftOffset() -> CGFloat
    
    func obtainErrorLabel() -> StandartOffsetLabel
    func obtainErrorImageView() -> UIImageView
}

// MARK: - MessageConfiguration

protocol MessageConfiguration: NavigationContainer {
    // MARK: - required
    
    var messageConfigurationDelegate: MessageConfigurationDelegate? { get set }
    var taskHideError: DispatchWorkItem! { get set }
    
    // MARK: - methods
    
    func showMessageWithText(_ text: String, andType type: MessageType)
    func showMessageWithText(_ text: String, andType type: MessageType, sender: Any?)
    
    func hideMessages()

}

extension MessageConfiguration {
    
    func showMessageWithText(_ text: String, andType type: MessageType) {
        self.showMessageWithText(text, andType: type, sender: nil)
    }
    
    func showMessageWithText(_ text: String, andType type: MessageType, sender: Any? = nil) {
        if let senderViewController = sender as? UIViewController, self.currentViewController != senderViewController {
            return
        }
        
        guard let messageWidth = self.messageConfigurationDelegate?.obtainMessageWidth(),
            let textOffset = self.messageConfigurationDelegate?.obtainTextOffset(),
            let iconHeight = self.messageConfigurationDelegate?.obtainIconHeight(),
            let leftOffset = self.messageConfigurationDelegate?.obtainLeftOffset(),
            let errorLabel = self.messageConfigurationDelegate?.obtainErrorLabel(),
            let errorImageView = self.messageConfigurationDelegate?.obtainErrorImageView() else { return }
        
        errorLabel.numberOfLines = 0
        errorLabel.font = FontProvider.default.informationMessage
        errorLabel.alpha = 0.0
        errorLabel.edgeInsets = UIEdgeInsets(top: self.statusHeight + textOffset, left: leftOffset, bottom: textOffset, right: textOffset)
        errorLabel.frame = CGRect(x: 0, y: 0, width: messageWidth, height: 0.0)
        errorLabel.text = text
        
        self.navigationController.view.addSubview(errorLabel)
        
        errorLabel.addSubview(errorImageView)
        
        switch type {
        case .success:
            errorLabel.textColor = ColorProvider.default.whiteColor
            errorLabel.backgroundColor = ColorProvider.messageColors.backgroundGreenColor
            errorImageView.image = ImageProvider.default.okIcon.withRenderingMode(.alwaysTemplate)
            errorImageView.tintColor = ColorProvider.default.whiteColor
        case .error:
            errorLabel.textColor = ColorProvider.default.whiteColor
            errorLabel.backgroundColor = ColorProvider.messageColors.backgroundRedColor
            errorImageView.image = ImageProvider.default.warnIcon.withRenderingMode(.alwaysTemplate)
            errorImageView.tintColor = ColorProvider.default.whiteColor
        case .warning:
            errorLabel.textColor = ColorProvider.default.blackColor
            errorLabel.backgroundColor = ColorProvider.messageColors.backgroundYellowColor
            errorImageView.image = ImageProvider.default.warnIcon.withRenderingMode(.alwaysTemplate)
            errorImageView.tintColor = ColorProvider.default.blackColor
        }
        
        let width = Double(messageWidth - leftOffset - textOffset)
        let height = FontProvider.default.informationMessage.sizeOfString(string: text, constrainedToWidth: width).height + (textOffset * 2) + 5
        
        errorImageView.frame = CGRect(x: textOffset, y: height/2 - iconHeight/2 + self.statusHeight, width: iconHeight, height: iconHeight)
        errorImageView.contentMode = .scaleAspectFit
        if #available(iOS 11.0, *) {
            errorImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let width = Double(messageWidth - leftOffset - textOffset)
            let height = FontProvider.default.informationMessage.sizeOfString(string: text, constrainedToWidth: width).height + (textOffset * 2) + 5
            errorLabel.frame = CGRect(x: 0, y: 0, width: messageWidth, height: height + self.statusHeight)
            errorLabel.alpha = 1.0
        })
        
        self.taskHideError?.cancel()
        self.taskHideError = DispatchWorkItem {
            if !self.taskHideError.isCancelled {
                self.hideMessages()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: self.taskHideError)
        errorLabel.isUserInteractionEnabled = true
    }
    
    func hideMessages() {
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            guard let messageWidth = self.messageConfigurationDelegate?.obtainMessageWidth(),
                let errorLabel = self.messageConfigurationDelegate?.obtainErrorLabel(),
                let errorImageView = self.messageConfigurationDelegate?.obtainErrorImageView() else { return }
            
            errorLabel.frame = CGRect(x: 0, y: 0, width: messageWidth, height: 0)
            errorImageView.removeFromSuperview()
        }, completion: nil)
    }
    
}

protocol NavigationConfiguration:
ModalObtainer,
NavigationBarConfiguration,
MenuConfiguration,
MessageConfiguration {
    
    var parentNavigationConfiguration: NavigationConfiguration? { get set }
    
//    public API
    
//    func containerForModal() -> ModalContainer?
//
//    func configureTransparentNavigationBar()
//    func configureNavigationBarWithColor(_ color: UIColor)
//
//    func emptyCustomBarLeftButtonAction()
//    func customBarLeftButtonAction(icon: UIImage, target: Any, action: Selector)
//    func customBarRightButtonAction(icon: UIImage, target: Any, action: Selector)
//    func customBarLeftTextButtonAction(text: String, target: Any, action: Selector)
//    func customBarRightTextButtonAction(text: String, target: Any, action: Selector)
//
//    func configureNavigationTitle(_ title: String)
//
//    func triggerMenu()
//    func openMenu()
//    func hideMenu()
//
//    func showMessageWithText(_ text: String, andType type: MessageType)
//    func showMessageWithText(_ text: String, andType type: MessageType, sender: Any?)
//
//    func hideMessages()
}

extension NavigationConfiguration {
    var menuConfiguration: MenuConfiguration? {
        get {
            return self
        }
        set {
            print(newValue ?? "no value")
        }
    }
    var idiomCheckerDelegate: IdiomCheckerDelegate? {
        get {
            return self as? IdiomCheckerDelegate
        }
        set {
            print(newValue ?? "no value")
        }
    }
    var messageConfigurationDelegate: MessageConfigurationDelegate? {
        get {
            return self as? MessageConfigurationDelegate
        }
        set {
            print(newValue ?? "no value")
        }
    }
}

extension IdiomCheckerDelegate where Self: NavigationConfiguration {
    var userInterfaceIdiom: UIUserInterfaceIdiom {
        guard let idiomCheckerDelegate = self.parentNavigationConfiguration as? IdiomCheckerDelegate else {
            return .phone
        }
        return idiomCheckerDelegate.userInterfaceIdiom
    }
}

extension MessageConfigurationDelegate where Self: NavigationConfiguration {
    func obtainMessageWidth() -> CGFloat {
        guard let messageConfigurationDelegate = self.parentNavigationConfiguration as? MessageConfigurationDelegate else {
            return 0.0
        }
        return messageConfigurationDelegate.obtainMessageWidth()
    }
    
    func obtainTextOffset() -> CGFloat {
        guard let messageConfigurationDelegate = self.parentNavigationConfiguration as? MessageConfigurationDelegate else {
            return 0.0
        }
        return messageConfigurationDelegate.obtainTextOffset()
    }
    
    func obtainIconHeight() -> CGFloat {
        guard let messageConfigurationDelegate = self.parentNavigationConfiguration as? MessageConfigurationDelegate else {
            return 0.0
        }
        return messageConfigurationDelegate.obtainIconHeight()
    }
    
    func obtainLeftOffset() -> CGFloat {
        guard let messageConfigurationDelegate = self.parentNavigationConfiguration as? MessageConfigurationDelegate else {
            return 0.0
        }
        return messageConfigurationDelegate.obtainLeftOffset()
    }
    
    func obtainErrorLabel() -> StandartOffsetLabel {
        guard let messageConfigurationDelegate = self.parentNavigationConfiguration as? MessageConfigurationDelegate else {
            return StandartOffsetLabel()
        }
        return messageConfigurationDelegate.obtainErrorLabel()
    }
    
    func obtainErrorImageView() -> UIImageView {
        guard let messageConfigurationDelegate = self.parentNavigationConfiguration as? MessageConfigurationDelegate else {
            return UIImageView()
        }
        return messageConfigurationDelegate.obtainErrorImageView()
    }
}


extension MenuConfiguration where Self: NavigationConfiguration {
    func triggerMenu() {
        guard let menuConfiguration = self.parentNavigationConfiguration else {
            return
        }
        menuConfiguration.triggerMenu()
    }
    
    func openMenu() {
        guard let menuConfiguration = self.parentNavigationConfiguration else {
            return
        }
        menuConfiguration.openMenu()
    }
    
    func hideMenu() {
        guard let menuConfiguration = self.parentNavigationConfiguration else {
            return
        }
        menuConfiguration.hideMenu()
    }
}
