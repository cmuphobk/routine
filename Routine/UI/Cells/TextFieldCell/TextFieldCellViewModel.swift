import UIKit

protocol TextFieldCellProtocol: class {
    func textChanged(object: RoutineTextFieldViewModel, newValue: String)
}

final class TextFieldCellViewModel: RoutineTableViewCellViewModel {
    let textFieldConfiguration: RoutineTextFieldViewModel
    weak var delegate: TextFieldCellProtocol?
    
    init(textFieldConfiguration: RoutineTextFieldViewModel, delegate: TextFieldCellProtocol?) {
        self.textFieldConfiguration = textFieldConfiguration
        self.delegate = delegate
    }
    
    override var reuseIdentifier: String {
        return "TextFieldCell"
    }
    
    override var cellOwner: RoutineCellOwner {
        return .type(value: TextFieldCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding  + self.textFieldConfiguration.height
    }
    
}
