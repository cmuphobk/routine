import UIKit

protocol TextFieldCellProtocol: class {
    func textChanged(object: LocalizedTextFieldViewModel, newValue: String)
}

final class TextFieldCellViewModel: LocalizedTableViewCellViewModel {
    let textFieldConfiguration: LocalizedTextFieldViewModel
    weak var delegate: TextFieldCellProtocol?
    
    init(textFieldConfiguration: LocalizedTextFieldViewModel, delegate: TextFieldCellProtocol?) {
        self.textFieldConfiguration = textFieldConfiguration
        self.delegate = delegate
    }
    
    override var reuseIdentifier: String {
        return "TextFieldCell"
    }
    
    override var cellOwner: CellOwner {
        return .type(value: TextFieldCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding  + self.textFieldConfiguration.height
    }
    
}
