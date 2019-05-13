import UIKit

final class StandartPagePickerCell: RoutineCollectionViewCell<StandartPagePickerCellViewModel> {
    
    @IBOutlet weak private var nameLabel: UILabel!
    
    override var isSelected: Bool {        
        didSet {
            if self.isSelected == true {
                self.nameLabel.alpha = 1.0
            } else {
                self.nameLabel.alpha = 0.5
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.nameLabel.font = self.viewModel.font
        self.nameLabel.textAlignment = .center
        self.nameLabel.textColor = self.viewModel.textColor
        self.paddingView.backgroundColor = self.viewModel.backgroundColor
        self.contentView.backgroundColor = self.viewModel.backgroundColor
    }
    
    override func localizationSetup() {
        self.nameLabel.text = self.viewModel.routineDelegate?.localize(self.viewModel.text) ?? ""
    }
    
}
