import UIKit
import Stevia

class SectionHeaderView: RoutineView<SectionHeaderViewModel> {
    weak var infoIcon: RoutineImageView<RoutineImageViewModel>!
    weak var textLabel: RoutineLabel<RoutineLabelViewModel>!
    weak var closeButton: RoutineButton<RoutineButtonViewModel>!

    override func setupView() {
        super.setupView()

        let infoIcon = RoutineImageView()
        let textLabel = RoutineLabel()
        let closeButton = RoutineButton()

        self.sv(
            infoIcon,
            textLabel,
            closeButton
        )

        self.infoIcon = infoIcon
        self.textLabel = textLabel
        self.closeButton = closeButton
    }

    override func setupLayout() {
        super.setupLayout()

        self.layout(
            |-self.viewModel.paddingOffsets.left-self.infoIcon-8-self.textLabel-(>=8.0)-self.closeButton-self.viewModel.paddingOffsets.right-|
        )

        self.infoIcon.height(12.0)
        self.infoIcon.Width == self.infoIcon.Height
        self.closeButton.height(12.0)
        self.closeButton.width(12.0)

        self.infoIcon.centerVertically()
        self.textLabel.centerInContainer()
        self.closeButton.centerInContainer()

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.infoIcon.configureView(config: self.viewModel.infoIconViewModel)
        self.textLabel.configureView(config: self.viewModel.textLabelViewModel)
        self.closeButton.configureView(config: self.viewModel.closeButtonViewModel)

        self.closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchDown)
    }

    @objc private func closeButtonAction(sender: UIButton) {
        self.viewModel.delegate?.didTriggerCloseButton(viewModel: self.viewModel)
    }
}
