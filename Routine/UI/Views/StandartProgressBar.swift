import UIKit

class StandartProgressBar: UIProgressView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
}
