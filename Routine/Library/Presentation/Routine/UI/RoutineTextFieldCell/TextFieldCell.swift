import UIKit
import Stevia

final class TextFieldCell: RoutineTableViewCell<TextFieldCellViewModel>, UITextFieldDelegate {

    weak var textField: RoutineTextField<RoutineTextFieldViewModel>!

    override func setupView() {
        super.setupView()

        let textField = RoutineTextField()

        self.paddingView.sv(
            textField
        )

        self.textField = textField
    }

    override func setupLayout() {
        super.setupLayout()

        self.layout(
            0.0,
            |self.textField|,
            0.0
        )

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.textField.configureView(config: self.viewModel.textFieldViewModel)
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(textFieldChangedAction), for: UIControl.Event.editingChanged)
    }

    override func localizationSetup() {
        self.textField.placeholder = self.viewModel.routineDelegate?.localize(self.viewModel.textFieldViewModel.placeholderText) ?? ""
    }

    @objc private func textFieldChangedAction(_ sender: UITextField) {
        self.viewModel.textFieldViewModel.text = sender.text ?? ""
        self.viewModel.delegate?.textChanged(object: self.viewModel.textFieldViewModel, newValue: sender.text ?? "")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }

 }
