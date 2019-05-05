import UIKit

protocol UsingTimesCellViewModelDelegate: class {
    func timeStartEdited(sender: UsingTimesCellViewModel)
    func textChanged(sender: UsingTimesCellViewModel)
}

final class UsingTimesCellViewModel: LocalizedTableViewCellViewModel {
    
    var numberLabel: LocalizedLabelViewModel = LocalizedLabelViewModel()
    var timesBox: LocalizedComboboxViewModel = LocalizedComboboxViewModel()
    var countField: LocalizedTextFieldViewModel = LocalizedTextFieldViewModel()
    
    weak var delegate: UsingTimesCellViewModelDelegate?
    
    override var reuseIdentifier: String {
        return "UsingTimesCell"
    }
    
    override var cellOwner: CellOwner {
        return .type(value: UsingTimesCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let viewHeight = max(self.numberLabel.font.sizeOfString(string: AppDelegate.serviceProvider.makeStringService().localizeById(self.numberLabel.text), constrainedToWidth: Double(width - self.leftAndRightPadding)).height,
                             self.timesBox.textFieldViewModel.height,
                             self.countField.height)
        
        return viewHeight + self.topAndBottomPadding
    }
    
}
