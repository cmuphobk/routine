import UIKit

protocol RoutineConfigure: class {
    func configureView(config: AnyObject)
}

protocol RoutineContainer: RoutineConfigure {
    associatedtype ViewModel: RoutineViewNamed

    var viewName: String? { get set }
    var viewModel: ViewModel! { get set }

    var didSetupConstraints: Bool { get }

    func configureView(config: ViewModel)

    func localizationSetup()

    func setupView()
    func setupLayout()
    func updateLayout()
    func setupViewModel()
}

extension RoutineContainer where Self: UIView {
    func setupView() {
        self.removeConstraints(self.constraints)
    }

    func setupLayout() { }

    func updateLayout() { }

    func localizationSetup() { }

    func configureView(config: AnyObject) {
        guard let config = config as? ViewModel else { return }
        self.configureView(config: config)
    }

    func configureView(config: ViewModel) {
        self.viewModel = config
        self.viewName = config.viewName
        self.setupViewModel()
        self.setNeedsLayout()
    }
}
