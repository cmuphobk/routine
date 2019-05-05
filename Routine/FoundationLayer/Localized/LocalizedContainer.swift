import UIKit

protocol LocalizedContainer: class {
    
    associatedtype ViewModel
    
    var viewName: String? { get set }
    var viewModel: ViewModel! { get set }
        
    var didSetupConstraints: Bool { get }
    
    func configureView(config: ViewModel)
    
    func localizationSetup()
    
}

protocol LocalizedConfigure: class {

    func configureView(config: AnyObject)
    
}
