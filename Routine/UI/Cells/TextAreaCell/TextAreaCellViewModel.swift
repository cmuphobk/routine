import UIKit

protocol TextAreaCellProtocol: class {
    func textBeginEdited(object: RoutineTextViewModel)
    func textChanged(object: RoutineTextViewModel, newValue: String)
}

final class TextAreaCellViewModel: RoutineTableViewCellViewModel {
    var textAreaConfiguration: RoutineTextViewModel = RoutineTextViewModel()
    weak var delegate: TextAreaCellProtocol?
    
    init(delegate: TextAreaCellProtocol) {
        self.delegate = delegate
    }
    
    override var reuseIdentifier: String {
        return "TextAreaCell"
    }
    
    override var cellOwner: RoutineCellOwner {
        return .type(value: TextAreaCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding + self.textAreaConfiguration.height
    }

}
