import UIKit

protocol RoutineComboboxCellProtocol: class {
    func expand(viewModel: RoutineComboboxViewModel)
}

final class RoutineComboboxCellViewModel: RoutineTableViewCellViewModel {
    lazy var combobox: RoutineComboboxViewModel = RoutineComboboxViewModel(routineDelegate: self.routineDelegate)
    weak var delegate: RoutineComboboxCellProtocol?

    init(delegate: RoutineComboboxCellProtocol, routineDelegate: RoutineDelegate?) {
        self.delegate = delegate

        super.init(routineDelegate: routineDelegate)
    }

    override var reuseIdentifier: String {
        return "ComboboxCell"
    }

    override var cellOwner: RoutineCellOwner {
        return .type(value: RoutineComboboxCell.self)
    }

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding + self.combobox.textFieldViewModel.height
    }

}
