
import Foundation

protocol OperationHandlerContainerInterface {
    
    associatedtype OperationHandler
    
    var handler: OperationHandler! { get set }
}
