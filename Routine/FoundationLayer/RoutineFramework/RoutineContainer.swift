import UIKit

protocol RoutineContainer: class {
    
    associatedtype ViewModel
    
    var viewName: String? { get set }
    var viewModel: ViewModel! { get set }
        
    var didSetupConstraints: Bool { get }
    
    func configureView(config: ViewModel)
    
    func localizationSetup()
    
}

protocol RoutineConfigure: class {

    func configureView(config: AnyObject)
    
}
