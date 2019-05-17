import UIKit

//Can see - https://github.com/umbrellaitcom/iOS-Clean-Architecture-with-Coordinator-pattern

protocol Navigationable {
    
    var navigationController: UINavigationController { get set }
    
    func present(viewController: UIViewController, animated: Bool)
    
    func push(viewController: UIViewController, animated: Bool)
    
    func pop(animated: Bool)
    
    func dismiss(animated: Bool)
    
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

protocol CoordinatorHandlerProtocol {
    associatedtype OfType
    func completion(with actionType: OfType)
}

class CoordinatorHandler<ActionType>: CoordinatorHandlerProtocol {
    typealias OfType = ActionType
    var closure: (ActionType) -> Void
    init(closure: @escaping (ActionType) -> Void) {
        self.closure = closure
    }
    func completion(with actionType: ActionType) {
        self.closure(actionType)
    }
}

class Coordinatorable<T: CoordinatorHandlerProtocol>: Navigationable {
    var navigationController: UINavigationController
    var flowHandler: T?
    init(navigationController: UINavigationController, flowHandler: T?) {
        self.navigationController = navigationController
        self.flowHandler = flowHandler
    }
    func start() {
        
    }
}
