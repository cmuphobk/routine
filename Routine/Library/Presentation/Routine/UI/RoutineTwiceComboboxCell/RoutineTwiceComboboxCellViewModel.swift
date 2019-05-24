import UIKit

protocol RoutineTwiceComboboxCellProtocol: class {
    func expandLeft(viewModel: RoutineComboboxViewModel)
    func expandRight(viewModel: RoutineComboboxViewModel)
}

final class RoutineTwiceComboboxCellViewModel: RoutineTableViewCellViewModel {
    
    lazy var leftCombobox: RoutineComboboxViewModel = RoutineComboboxViewModel(routineDelegate: self.routineDelegate)
    lazy var rightCombobox: RoutineComboboxViewModel = RoutineComboboxViewModel(routineDelegate: self.routineDelegate)
    var betweenSpace: CGFloat = 8.0
    var betweenPosition = 0.5  // в процентах
    
    weak var delegate: RoutineTwiceComboboxCellProtocol?
    
    init(delegate: RoutineTwiceComboboxCellProtocol?, routineDelegate: RoutineDelegate?) {
        self.delegate = delegate
        
        super.init(routineDelegate: routineDelegate)
    }
    
    override var reuseIdentifier: String {
        return "TwiceComboboxCell"
    }
    
    override var cellOwner: RoutineCellOwner {
        return .type(value: RoutineTwiceComboboxCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding + max(self.leftCombobox.textFieldViewModel.height, self.rightCombobox.textFieldViewModel.height)
    }

}
