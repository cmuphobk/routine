import UIKit

final class StandartPagePickerCellViewModel: LocalizedCollectionViewCellViewModel {
    let text: String
    let font: UIFont
    let textColor: UIColor
    let height: CGFloat
    
    init(text: String, size: CGSize, isSelected: Bool, font: UIFont, textColor: UIColor, backgroundColor: UIColor) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.height = size.height
        
        super.init()
        
        self.backgroundColor = backgroundColor
        self.isSelected = isSelected
        self.width = size.width
    }
    
    override var reuseIdentifier: String {
        return "StandartPagePickerCell"
    }
    
    override var cellOwner: CellOwner {
        return .nib(value: UINib(nibName: self.reuseIdentifier, bundle: nil))
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.height
    }
    
}
