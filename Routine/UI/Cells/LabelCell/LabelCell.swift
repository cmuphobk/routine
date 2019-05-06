import UIKit
import Stevia

final class LabelCell: RoutineTableViewCell<LabelCellViewModel> {
    weak private var label: RoutineLabel<RoutineLabelViewModel>!
    
    override func setupView() {
        super.setupView()
        
        let label = RoutineLabel()
        
        self.paddingView.sv(
            label
        )
        
        self.label = label
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        layout(
            0,
            |self.label|,
            0
        )
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.label.configureView(config: self.viewModel.labelConfiguration)
    }
    
    override func localizationSetup() {
        self.label.text = AppDelegate.serviceProvider.makeStringService().localizeById(self.viewModel.labelConfiguration.text)
    }

}
