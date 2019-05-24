import UIKit

//FIXME: ViewModel
class RoutineCheckBoxButton: RoutineButton<RoutineCheckBoxButtonViewModel> {
    
    // Images
    private let checkedImageView = UIImageView(image: ImageProvider.default.checkboxPressedIcon)
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if self.isChecked == true {
                self.backgroundColor = ColorProvider.default.lightGrayColor
                self.checkedImageView.isHidden = false
                
            } else {
                self.backgroundColor = ColorProvider.default.whiteColor
                self.checkedImageView.isHidden = true
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rect = CGRect(x: self.frame.width - 24.0, y: self.frame.height/2 - 8.0, width: 16.0, height: 16.0)
        self.checkedImageView.frame = rect
        
    }
    
    override func setupViewModel() {
        super.setupViewModel()
        
        let is5sAndLess = self.viewModel.windowService.is5sAndLess
        
        self.setTitle(nil, for: .normal)
        self.tintColor = ColorProvider.default.blackColor
        self.titleLabel?.textColor = ColorProvider.default.blackColor
        self.titleLabel?.font = is5sAndLess ? FontProvider.default.blackSmallButton : FontProvider.default.blackButton
        self.titleLabel?.textAlignment = .center
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = 5.0
        
        self.layer.shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.16).cgColor
        self.layer.shadowOpacity = 0.16
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        self.addSubview(self.checkedImageView)
    }
    
}
