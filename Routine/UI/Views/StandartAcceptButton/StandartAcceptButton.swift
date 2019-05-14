import UIKit

class StandartAcceptButton: RoutineButton<StandartAcceptButtonViewModel> {
        
    override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            self.backgroundColor = newValue == true ? ColorProvider.default.blueColor : ColorProvider.default.lightGrayColor
            super.isEnabled = newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.16).cgColor
        self.layer.shadowOpacity = 0.16
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        self.layer.cornerRadius = 5.0
        self.backgroundColor = ColorProvider.default.blueColor
        self.setTitleColor(ColorProvider.default.whiteColor, for: .normal)
        
        let is5sAndLess = self.viewModel.windowService.is5sAndLess
        
        self.titleLabel?.font = is5sAndLess ? FontProvider.default.blueSmallButton : FontProvider.default.blueButton
    }

}
