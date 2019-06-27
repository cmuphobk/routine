import UIKit

//Can see - https://github.com/umbrellaitcom/iOS-Clean-Architecture-with-Coordinator-pattern

protocol Navigationable {
    var navigationController: UINavigationController { get set }
    func present(viewController: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
    func push(viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

extension Navigationable {
    func present(viewController: UIViewController, animated: Bool) {
        self.navigationController.present(viewController, animated: animated, completion: nil)
    }
    func push(viewController: UIViewController, animated: Bool) {
        self.navigationController.pushViewController(viewController, animated: animated)
    }
    func pop(animated: Bool) {
        self.navigationController.popViewController(animated: animated)
    }
    func dismiss(animated: Bool) {
        self.navigationController.dismiss(animated: animated, completion: nil)
    }
}

protocol Coordinatorable: AnyObject, Navigationable {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinatorable? { get set }

    var childCoordinators: [Coordinatorable] { get set }
    var childViewControllers: [UIViewController] { get set }

    init(navigationController: UINavigationController)
    func start()
    func childNeedFinish(_ child: Coordinatorable)

    func childDidFinish(_ child: Coordinatorable)
    func viewControllerDidBackForward(_ viewController: UIViewController)
}

extension Coordinatorable {
    // FIXME: - не тестировалось
    func viewControllerDidBackForward(_ viewController: UIViewController) {
        for childCoordinator in self.childCoordinators {
            if let index = childCoordinator.childViewControllers.index(ref: viewController) {
                childCoordinator.childViewControllers.remove(at: index)
                if childCoordinator.childViewControllers.count == 0 {
                    childCoordinator.parentCoordinator?.childNeedFinish(self)
                }
                return
            }
            childCoordinator.viewControllerDidBackForward(viewController)
        }
    }

    func childNeedFinish(_ child: Coordinatorable) {
        let childCoordinators = self.childCoordinators as [AnyObject]
        if let index = childCoordinators.index(ref: child) {

            for childOfChild in child.childCoordinators {
                child.childNeedFinish(childOfChild)
            }

            for viewController in child.childViewControllers {
                if let index = child.navigationController.viewControllers.index(ref: viewController) {
                    child.navigationController.viewControllers.remove(at: index)
                }
            }

            self.childCoordinators.remove(at: index)
            self.childDidFinish(self)
            return
        }
    }
}

extension Navigationable where Self: Coordinatorable {
    func present(viewController: UIViewController, animated: Bool) {
        self.navigationController.present(viewController, animated: animated, completion: nil)
    }

    func push(viewController: UIViewController, animated: Bool) {
        self.childViewControllers.append(viewController)
        self.navigationController.pushViewController(viewController, animated: animated)
    }

    func pop(animated: Bool) {
        guard let viewController = self.navigationController.popViewController(animated: animated) else { return }

        if let index = self.childViewControllers.index(ref: viewController) {
            self.childViewControllers.remove(at: index)
            if self.childViewControllers.count == 0 {
                self.parentCoordinator?.childNeedFinish(self)
            }
            return
        }
    }

    func dismiss(animated: Bool) {
        self.navigationController.dismiss(animated: animated, completion: nil)
    }
}
