import UIKit

protocol TwiceComboboxCellProtocol: class {
    func expandLeft(viewModel: RoutineComboboxViewModel)
    func expandRight(viewModel: RoutineComboboxViewModel)
}

final class TwiceComboboxCellViewModel: RoutineTableViewCellViewModel {
    
    var leftCombobox: RoutineComboboxViewModel = RoutineComboboxViewModel()
    var rightCombobox: RoutineComboboxViewModel = RoutineComboboxViewModel()
    var betweenSpace: CGFloat = 8.0
    var betweenPosition = 0.5  // в процентах
    
    weak var delegate: TwiceComboboxCellProtocol?
    
    init(delegate: TwiceComboboxCellProtocol?) {
        self.delegate = delegate
    }
    
    override var reuseIdentifier: String {
        return "TwiceComboboxCell"
    }
    
    override var cellOwner: RoutineCellOwner {
        return .type(value: TwiceComboboxCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding + max(self.leftCombobox.textFieldViewModel.height, self.rightCombobox.textFieldViewModel.height)
    }

}
