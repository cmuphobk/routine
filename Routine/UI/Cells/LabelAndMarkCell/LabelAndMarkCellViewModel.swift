import Foundation
import UIKit

final class LabelAndMarkCellViewModel: LocalizedTableViewCellViewModel {
    var label: LocalizedLabelViewModel = LocalizedLabelViewModel()
    var image: LocalizedImageViewModel = LocalizedImageViewModel()
    var betweenSpace: CGFloat = 8.0
    
    override var reuseIdentifier: String {
        return "LabelAndMarkCellViewModel"
    }
    
    override var cellOwner: CellOwner {
        return .type(value: LabelAndMarkCell.self) 
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return 52
    }
}
