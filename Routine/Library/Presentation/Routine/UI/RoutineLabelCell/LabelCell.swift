import UIKit
import Stevia

final class LabelCell: RoutineTableViewCell<LabelCellViewModel> {
    lazy private var label = RoutineLabel()

    override func setupView() {
        super.setupView()

        self.paddingView.sv(
            self.label
        )

    }

    override func setupLayout() {
        super.setupLayout()

        self.layout(
            0,
            |self.label|,
            0
        )

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.label.configureView(config: self.viewModel.labelViewModel)
    }

    override func localizationSetup() {
        self.label.text = self.viewModel.routineDelegate?.localize(self.viewModel.labelViewModel.text)
    }

}
