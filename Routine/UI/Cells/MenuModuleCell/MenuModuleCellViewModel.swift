import UIKit

final class MenuModuleCellViewModel: RoutineTableViewCellViewModel {
    
    var text: String = ""
    
    override var reuseIdentifier: String {
        return "MenuModuleCell"
    }
    
    override var cellOwner: RoutineCellOwner {
        return .nib(value: UINib(nibName: self.reuseIdentifier, bundle: nil))
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return 52.0
    }

}
