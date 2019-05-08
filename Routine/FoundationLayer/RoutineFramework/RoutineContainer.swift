import UIKit

protocol RoutinePrivateConfigure: class {
    func configure()
}

protocol RoutineConfigure: class {
    func configureView(config: AnyObject)
}


protocol RoutineContainer: class {
    
    associatedtype ViewModel: RoutineViewModel
    
    var viewName: String? { get set }
    var viewModel: ViewModel! { get set }
        
    var didSetupConstraints: Bool { get }
    
    func configureView(config: ViewModel)
    func configureView(config: AnyObject)
    
    func localizationSetup()
    
    func setupView()
    func setupLayout()
    func updateLayout()
    
}

extension RoutineContainer where Self: UIView {
    
    func setupView() {
        self.removeConstraints(self.constraints)
    }
    
    func setupLayout() { }
    
    func updateLayout() { }
    
    func localizationSetup() { }
    
    func configureView(config: AnyObject) {
        if config.isKind(of: ViewModel.self) {
            guard let config = config as? ViewModel else { return }
            self.configureView(config: config)
        }
    }
    
}

extension RoutineContainer where Self: UIView, Self: RoutinePrivateConfigure {
    func configureView(config: ViewModel) {
        self.viewModel = config
        self.viewName = config.viewName
        
        self.configure()
        
        self.setNeedsLayout()
    }
}
