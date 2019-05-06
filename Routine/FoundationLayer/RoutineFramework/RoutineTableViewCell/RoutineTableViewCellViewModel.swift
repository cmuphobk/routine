import UIKit

class RoutineTableViewCellViewModel: RoutineViewModel {
    
    var reuseIdentifier: String? {
        return nil
    }
    
    var cellOwner: CellOwner? {
        return nil
    }
    var isSelected: Bool = false
    var selectionStyle: UITableViewCell.SelectionStyle = .none
    var backgroundViewColor: UIColor = UIColor.white
    var contentViewColor: UIColor = UIColor.clear
    var isExpand: Bool = false

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return super.heightForWidth(width)
    }
        
}
