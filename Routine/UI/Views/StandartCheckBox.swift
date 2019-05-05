import UIKit

class StandartCheckBox: UIButton {
    // Images
    private let checkedImage = ImageProvider.default.checkboxPressedIcon
    private let uncheckedImage = ImageProvider.default.checkboxIcon
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if self.isChecked == true {
                self.setBackgroundImage(self.checkedImage, for: .normal)
            } else {
                self.setBackgroundImage(self.uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchDown)
        
        self.setTitle(nil, for: .normal)
        self.tintColor = ColorProvider.default.clearColor
        self.contentMode = .scaleAspectFit
        
        self.isChecked = false
    }
    
    @objc private func buttonClicked(sender: UIButton) {
        if sender == self {
            self.isChecked = !self.isChecked
        }
    }
}
