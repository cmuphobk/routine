import UIKit
import SnapKit

struct MainViewModel {
    var titleButton: String
    var text: String

    init(titleButton: String) {
        self.titleButton = titleButton
        self.text = ""
    }

    var title: String {
        return "\(self.titleButton) \(self.text)"
    }

    mutating func change(title: String) {
        self.text = title
    }
}

final class MainViewController: UIViewController, BaseView {
    var output: MainViewOutput!

    var color: ColorTheme!
    var font: FontTheme!
    var image: ImageTheme!

    var viewModel: MainViewModel! {
        didSet {
            self.button.setTitle(self.viewModel.title, for: .normal)
        }
    }

    weak var textField: UITextField!
    weak var button: UIButton!

    override func loadView() {
        super.loadView()

        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.addTarget(self, action: #selector(textFieldAction), for: .editingChanged)
        self.view.addSubview(textField)
        self.textField = textField

        let button = UIButton()
        button.setTitleColor(self.color.blackColor, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchDown)
        self.view.addSubview(button)
        self.button = button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.didTriggerViewReadyEvent()

        self.button.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.center)
        }
        self.textField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.button.snp.top).offset(-20.0)
            make.width.equalTo(300.0)
            make.height.equalTo(40.0)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.didTriggerViewWillAppear()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

    }
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    func setup(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Action
extension MainViewController {
    @objc func buttonAction(sender: UIButton) {
        self.output.didTriggerHelloWorld()
    }

    @objc func textFieldAction(sender: UITextField) {
        self.viewModel.change(title: sender.text ?? "")
    }
}
