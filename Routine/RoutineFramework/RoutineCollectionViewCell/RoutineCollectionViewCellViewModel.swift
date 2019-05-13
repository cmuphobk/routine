import UIKit

class RoutineCollectionViewCellViewModel: RoutineViewModel {
    
    var reuseIdentifier: String? {
        return nil
    }
    
    var cellOwner: RoutineCellOwner? {
        return nil
    }
    var isSelected: Bool = false
    var backgroundViewColor: UIColor = UIColor.white
    var isExpand: Bool = false
    
    var width: CGFloat = 0.0
    
}
