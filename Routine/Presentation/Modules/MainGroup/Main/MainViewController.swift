import UIKit
import Stevia

final class MainViewController: UIViewController, BaseView {
    var output: MainViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.didTriggerViewReadyEvent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.didTriggerViewWillAppear()
    }
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    func setupInitialState() {
    }
}
