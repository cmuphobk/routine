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

protocol Coordinatorable: Navigationable {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinatorable] { get set }
    
    init(navigationController: UINavigationController)
    func start()
}
