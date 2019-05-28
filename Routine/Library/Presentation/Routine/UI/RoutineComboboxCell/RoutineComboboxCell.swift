import UIKit
import Stevia

final class RoutineComboboxCell: RoutineTableViewCell<RoutineComboboxCellViewModel> {

    weak var combobox: RoutineCombobox!

    override func setupView() {
        super.setupView()

        let combobox = RoutineCombobox()

        self.paddingView.sv(
            combobox
        )

        self.combobox = combobox
    }

    override func setupLayout() {
        super.setupLayout()

        self.layout(
            0,
            |self.combobox|,
            0
        )

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.combobox.configureView(config: self.viewModel.combobox)
        self.combobox.delegate = self
    }

    override func localizationSetup() {
        guard let viewModel = self.viewModel else { return }
        let text = viewModel.routineDelegate?.localize(viewModel.combobox.textFieldViewModel.text)
        let placehodler = viewModel.routineDelegate?.localize(viewModel.combobox.textFieldViewModel.placeholderText)
        self.combobox.textField.text = text ?? ""
        self.combobox.textField.placeholder = placehodler ?? ""
    }
}

// MARK: UIComboboxDelegate
extension RoutineComboboxCell: RoutineComboboxDelegate {

    func comboboxDidPressed(viewModel: RoutineComboboxViewModel) {
        if viewModel == self.combobox.viewModel {
            self.viewModel.delegate?.expand(viewModel: viewModel)
        }
    }

}
