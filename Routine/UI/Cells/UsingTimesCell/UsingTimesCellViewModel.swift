import UIKit

protocol UsingTimesCellViewModelDelegate: class {
    func timeStartEdited(sender: UsingTimesCellViewModel)
    func textChanged(sender: UsingTimesCellViewModel)
}

final class UsingTimesCellViewModel: RoutineTableViewCellViewModel {
    
    var numberLabel: RoutineLabelViewModel = RoutineLabelViewModel()
    var timesBox: RoutineComboboxViewModel = RoutineComboboxViewModel()
    var countField: RoutineTextFieldViewModel = RoutineTextFieldViewModel()
    
    weak var delegate: UsingTimesCellViewModelDelegate?
    
    override var reuseIdentifier: String {
        return "UsingTimesCell"
    }
    
    override var cellOwner: RoutineCellOwner {
        return .type(value: UsingTimesCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let viewHeight = max(self.numberLabel.font.sizeOfString(string: AppDelegate.serviceProvider.makeStringService().localizeById(self.numberLabel.text), constrainedToWidth: Double(width - self.leftAndRightPadding)).height,
                             self.timesBox.textFieldViewModel.height,
                             self.countField.height)
        
        return viewHeight + self.topAndBottomPadding
    }
    
}
