import UIKit
import Stevia

final class MainViewController: RoutineViewController, BaseView {
    var output: MainViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.didTriggerViewReadyEvent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.didTriggerViewWillAppear()

    }

    override func localizationSetup() {
        super.localizationSetup()
        self.output.configureNavigationBar(title: self.output.localizeService.localizeId(self.output.name))
    }

}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    func setupInitialState() {
        
    }
}
