import UIKit

protocol ApplicationCoordinatorDelegate: class {

}

class ApplicationCoordinator: NSObject, Coordinatorable, ScreenEventManager {

    // MARK: - Coordinatorable
    var navigationController: UINavigationController
    var parentCoordinator: Coordinatorable?

    var childCoordinators: [Coordinatorable] = []
    var childViewControllers: [UIViewController] = []

    // MARK: - ScreenEventManager
    var parentScreenEventManager: ScreenEventManager?
    var taskHideError: DispatchWorkItem!

    // MARK: - ApplicationCoordinator
    var rootView: UIView!
    var windowService: WindowServiceInterface!
    var moduleService: ModuleServiceInterface!

    var factory = ApplicationModuleFactory()
    var coordinatorFactory = ApplicationCoordinatorFactory()
    weak var delegate: ApplicationCoordinatorDelegate?

    var menuModule: Module!
    var menuViewController: UIViewController {
        return self.menuModule.viewController
    }
    let menuViewWidth: CGFloat = 300.0
    let standartOffsetLabel = RoutineOffsetLabel()
    let imageView = UIImageView()

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.delegate = self
        self.factory.makeMenuViewController(with: self) { (moduleInput) in
            moduleInput?.configureModule(menuItems: self.moduleService.obtainAvailableModulesAndActionsIds())
            if let viewController = moduleInput?.viewController {
                viewController.view.frame = CGRect(x: -self.menuViewWidth, y: 0, width: self.menuViewWidth, height: self.view.frame.height)
                self.rootView.addSubview(viewController.view)
                self.menuModule = moduleInput
            }
        }

        let mainCoordinator = self.coordinatorFactory.makeMainCoordinator(navigationController: self.navigationController,
                                                                          delegate: self,
                                                                          parentScreenEventManager: self)
        self.childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }

    func childDidFinish(_ child: Coordinatorable) {

    }
}

extension ApplicationCoordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }

        if navigationController.viewControllers.contains(fromViewController) { return }

        self.viewControllerDidBackForward(fromViewController)
    }

}

extension ApplicationCoordinator: MenuRouterOutput {

    func openModuleById(_ identifier: String) {

        for child in self.childCoordinators {
            self.childNeedFinish(child)
        }

        switch identifier {
        case R.string.localizable.main_name.key:
            let mainCoordinator = self.coordinatorFactory.makeMainCoordinator(navigationController: self.navigationController,
                                                                              delegate: self,
                                                                              parentScreenEventManager: self)
            self.childCoordinators.append(mainCoordinator)
            mainCoordinator.start()

        default: return
        }
    }
}

extension ApplicationCoordinator: MainCoordinatorDelegate {

}

extension ApplicationCoordinator: IdiomCheckerDelegate {

    var idiomCheckerDelegate: IdiomCheckerDelegate? {
        get {
            return self
        }
        set {
            print(newValue ?? "no value")
        }
    }

    var userInterfaceIdiom: UIUserInterfaceIdiom {
        return self.windowService.userInterfaceIdiom
    }
}

extension ApplicationCoordinator: MessageManagerDelegate {

    var messageManagerDelegate: MessageManagerDelegate? {
        get {
            return self
        }
        set {
            print(newValue ?? "no value")
        }
    }

    func obtainMessageWidth() -> CGFloat {
        return self.windowService.screenWidth
    }

    func obtainTextOffset() -> CGFloat {
        return 15.0
    }

    func obtainIconHeight() -> CGFloat {
        return 25.0
    }

    func obtainLeftOffset() -> CGFloat {
        return 0.0
    }

    func obtainErrorLabel() -> RoutineOffsetLabel {
        return self.standartOffsetLabel
    }

    func obtainErrorImageView() -> UIImageView {
        return self.imageView
    }
}

// MARK: - MessageManager
extension ApplicationCoordinator {

    func showMessageWithText(_ text: String,
                             andType type: MessageType,
                             sender: Any? = nil) {
        if let senderViewController = sender as? UIViewController, self.currentViewController != senderViewController {
            return
        }

        guard let messageWidth = self.messageManagerDelegate?.obtainMessageWidth(),
            let textOffset = self.messageManagerDelegate?.obtainTextOffset(),
            let iconHeight = self.messageManagerDelegate?.obtainIconHeight(),
            let leftOffset = self.messageManagerDelegate?.obtainLeftOffset(),
            let errorLabel = self.messageManagerDelegate?.obtainErrorLabel(),
            let errorImageView = self.messageManagerDelegate?.obtainErrorImageView() else { return }

        errorLabel.numberOfLines = 0
        errorLabel.font = FontProvider.default.informationMessage
        errorLabel.alpha = 0.0
        errorLabel.edgeInsets = UIEdgeInsets(top: self.statusHeight + textOffset,
                                             left: leftOffset,
                                             bottom: textOffset,
                                             right: textOffset)
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
        let height = FontProvider.default.informationMessage.sizeOfStringLabel(string: text, constrainedToWidth: width).height + (textOffset * 2) + 5

        errorImageView.frame = CGRect(x: textOffset, y: height/2 - iconHeight/2 + self.statusHeight, width: iconHeight, height: iconHeight)
        errorImageView.contentMode = .scaleAspectFit
        if #available(iOS 11.0, *) {
            errorImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        }

        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let width = Double(messageWidth - leftOffset - textOffset)
            let height = FontProvider.default.informationMessage.sizeOfStringLabel(string: text, constrainedToWidth: width).height + (textOffset * 2) + 5
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

            guard let messageWidth = self.messageManagerDelegate?.obtainMessageWidth(),
                let errorLabel = self.messageManagerDelegate?.obtainErrorLabel(),
                let errorImageView = self.messageManagerDelegate?.obtainErrorImageView() else { return }

            errorLabel.frame = CGRect(x: 0, y: 0, width: messageWidth, height: 0)
            errorImageView.removeFromSuperview()
        }, completion: nil)
    }

}

// MARK: - MenuManager
extension ApplicationCoordinator {

    func triggerMenu() {
        if self.menuViewController.view.frame.origin.x < 0 {
            self.openMenu()
        } else {
            self.hideMenu()
        }
    }

    func openMenu() {
        self.menuViewController.view.frame = CGRect(x: -self.menuViewWidth, y: 0, width: self.menuViewWidth, height: self.view.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.menuViewController.view.frame = CGRect(x: 0, y: 0, width: self.menuViewWidth, height: self.view.frame.height)
            self.navigationController.view.frame = CGRect(x: self.menuViewWidth, y: 0, width: self.view.frame.width, height: self.view.frame.height)

            self.view.setNeedsLayout()
        }, completion: nil)
    }

    func hideMenu() {
        self.menuViewController.view.frame = CGRect(x: 0, y: 0, width: self.menuViewWidth, height: self.view.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.menuViewController.view.frame = CGRect(x: -self.menuViewWidth, y: 0, width: self.menuViewWidth, height: self.view.frame.height)
            self.navigationController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

            self.view.setNeedsLayout()
        }, completion: nil)
    }

}
