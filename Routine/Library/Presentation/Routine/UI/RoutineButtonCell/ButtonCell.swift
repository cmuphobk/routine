import UIKit
import Stevia

final class ButtonCell: RoutineTableViewCell<ButtonCellViewModel> {

    weak var button: RoutineButton<RoutineButtonViewModel>!

    override func setupView() {
        super.setupView()

        let button = RoutineButton()

        self.paddingView.sv(
            button
        )

        self.button = button
    }

    override func setupLayout() {
        super.setupLayout()

        self.layout(
            0,
            |self.button|,
            0
        )

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.button.configureView(config: self.viewModel.buttonViewModel)
        self.button.addTarget(self, action: #selector(buttonDidPressed), for: UIControl.Event.touchUpInside)
    }

    override func localizationSetup() {
        self.button.setTitle(self.viewModel.routineDelegate?.localize(self.viewModel.buttonViewModel.text) ?? "", for: .normal)
    }

    @IBAction private func buttonDidPressed(_ sender: UIButton) {
        guard let button = sender as? RoutineButton<RoutineButtonViewModel> else {
            return
        }
        self.viewModel.delegate?.buttonDidPressed(sender: button)
    }
}
