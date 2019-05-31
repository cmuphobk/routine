import UIKit
import Stevia

class SectionDescriptionView: RoutineView {
    
//    SectionDescriptionViewModel

    weak var descriptionLabel: RoutineLabel<RoutineLabelViewModel>!

    override func setupView() {
        super.setupView()

        let descriptionLabel = RoutineLabel()

        self.sv(
            descriptionLabel
        )

        self.descriptionLabel = descriptionLabel
    }

    override func setupLayout() {
        super.setupLayout()

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.descriptionLabel.configureView(config: self.viewModel.descriptionLabelViewModel)
    }

}
