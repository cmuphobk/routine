import UIKit
import SnapKit

struct HelloWorldViewModel {

}

final class HelloWorldViewController: UIViewController, BaseView {
    var output: HelloWorldViewOutput!

    var color: ColorTheme!
    var font: FontTheme!
    var image: ImageTheme!

    var viewModel: HelloWorldViewModel!

    override func loadView() {
        super.loadView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.didTriggerViewReadyEvent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.didTriggerViewWillAppear()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

    }
}

// MARK: - HelloWorldViewInput
extension HelloWorldViewController: HelloWorldViewInput {
    func setup(viewModel: HelloWorldViewModel) {
        self.viewModel = viewModel
    }
}
