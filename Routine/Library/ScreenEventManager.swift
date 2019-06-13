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
    var navigationBarHeight: CGFloat { get }
    var statusBarHeight: CGFloat { get }
}

extension NavigationContainer {
    var currentViewController: UIViewController? { return self.navigationController.viewControllers.last }

    var view: UIView { return self.navigationController.view }

    var statusHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }
    var navigationBarHeight: CGFloat { return self.navigationController.navigationBar.frame.height }
    var statusBarHeight: CGFloat { return self.statusHeight + self.navigationBarHeight }
}

// MARK: - ModalManager
protocol ModalManager: class {
    // MARK: - methods
    func containerForModal() -> ModalContainer?
}

extension ModalManager where Self: UIViewController {
    func containerForModal() -> ModalContainer? {
        guard let view = self.view else { return nil }
        return ModalContainer(view: view, viewController: self)
    }
}

extension ModalManager where Self: NavigationContainer {
    func containerForModal() -> ModalContainer? {
        guard let view = self.navigationController.view else { return nil }
        return ModalContainer(view: view, viewController: self.navigationController)
    }
}

// MARK: - NavigationBarManager
protocol IdiomCheckerDelegate: class {
    var userInterfaceIdiom: UIUserInterfaceIdiom { get }
}

protocol NavigationBarManager: NavigationContainer {
    // MARK: - optional
    var idiomCheckerDelegate: IdiomCheckerDelegate? { get set }
    var menuManager: MenuManager? { get set }

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

extension NavigationBarManager {

    func emptyCustomBarLeftButtonAction() {
        if let idiomCheckerDelegate = self.idiomCheckerDelegate, idiomCheckerDelegate.userInterfaceIdiom != .pad {
            self.menuManager?.hideMenu()
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
                self.menuManager?.openMenu()
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
                self.menuManager?.openMenu()
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

// MARK: - MenuManager
protocol MenuManager: NavigationContainer {
    // MARK: - methods
    func triggerMenu()
    func hideMenu()
    func openMenu()
}

// MARK: - MessageManager

protocol MessageManagerDelegate: class {
    func obtainMessageWidth() -> CGFloat
    func obtainTextOffset() -> CGFloat
    func obtainIconHeight() -> CGFloat
    func obtainLeftOffset() -> CGFloat

    func obtainErrorLabel() -> UILabel
    func obtainErrorImageView() -> UIImageView
}

protocol MessageManager: NavigationContainer {
    // MARK: - required
    var messageManagerDelegate: MessageManagerDelegate? { get set }
    var taskHideError: DispatchWorkItem! { get set }

    // MARK: - methods
    func showMessageWithText(_ text: String, andType type: MessageType)
    func showMessageWithText(_ text: String, andType type: MessageType, sender: Any?)

    func hideMessages()
}

protocol ScreenEventManager:
ModalManager,
NavigationBarManager,
MenuManager,
MessageManager {
    var parentScreenEventManager: ScreenEventManager? { get set }
}

extension ScreenEventManager {
    var idiomCheckerDelegate: IdiomCheckerDelegate? {
        get {
            return self.parentScreenEventManager as? IdiomCheckerDelegate
        }
        set {
            print(newValue ?? "no value")
        }
    }

    var userInterfaceIdiom: UIUserInterfaceIdiom {
        guard let idiomCheckerDelegate = self.idiomCheckerDelegate else {
            return .phone
        }
        return idiomCheckerDelegate.userInterfaceIdiom
    }
}

extension ScreenEventManager {
    var messageManagerDelegate: MessageManagerDelegate? {
        get {
            return self.parentScreenEventManager as? MessageManagerDelegate
        }
        set {
            print(newValue ?? "no value")
        }
    }

    func obtainMessageWidth() -> CGFloat {
        guard let messageManagerDelegate = self.messageManagerDelegate else {
            return 0.0
        }
        return messageManagerDelegate.obtainMessageWidth()
    }

    func obtainTextOffset() -> CGFloat {
        guard let messageManagerDelegate = self.messageManagerDelegate else {
            return 0.0
        }
        return messageManagerDelegate.obtainTextOffset()
    }

    func obtainIconHeight() -> CGFloat {
        guard let messageManagerDelegate = self.messageManagerDelegate else {
            return 0.0
        }
        return messageManagerDelegate.obtainIconHeight()
    }

    func obtainLeftOffset() -> CGFloat {
        guard let messageManagerDelegate = self.messageManagerDelegate else {
            return 0.0
        }
        return messageManagerDelegate.obtainLeftOffset()
    }

    func obtainErrorLabel() -> UILabel {
        guard let messageManagerDelegate = self.messageManagerDelegate else {
            return UILabel()
        }
        return messageManagerDelegate.obtainErrorLabel()
    }

    func obtainErrorImageView() -> UIImageView {
        guard let messageManagerDelegate = self.messageManagerDelegate else {
            return UIImageView()
        }
        return messageManagerDelegate.obtainErrorImageView()
    }
}

extension ScreenEventManager {
    var menuManager: MenuManager? {
        get {
            return self
        }
        set {
            print(newValue ?? "no value")
        }
    }
    func triggerMenu() {
        guard let menuManager = self.parentScreenEventManager else {
            return
        }
        menuManager.triggerMenu()
    }

    func openMenu() {
        guard let menuManager = self.parentScreenEventManager else {
            return
        }
        menuManager.openMenu()
    }

    func hideMenu() {
        guard let menuManager = self.parentScreenEventManager else {
            return
        }
        menuManager.hideMenu()
    }
}

extension ScreenEventManager {

    func showMessageWithText(_ text: String, andType type: MessageType) {
        self.showMessageWithText(text, andType: type, sender: nil)
    }

    func showMessageWithText(_ text: String, andType type: MessageType, sender: Any? = nil) {
        if let messageManager = self.parentScreenEventManager {
            messageManager.showMessageWithText(text, andType: type, sender: sender)
        }
    }

    func hideMessages() {
        if let messageManager = self.parentScreenEventManager {
            messageManager.hideMessages()
        }
    }

}
