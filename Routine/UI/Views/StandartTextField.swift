import UIKit

class StandartTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textColor = ColorProvider.default.blackColor
        self.textAlignment = .center
        
    }

}
