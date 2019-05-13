import UIKit

protocol ComboboxCellProtocol: class {
    func expand(viewModel: RoutineComboboxViewModel)
}

final class ComboboxCellViewModel: RoutineTableViewCellViewModel {
    lazy var combobox: RoutineComboboxViewModel = RoutineComboboxViewModel(routineDelegate: self.routineDelegate)
    weak var delegate: ComboboxCellProtocol?
    
    init(delegate: ComboboxCellProtocol, routineDelegate: RoutineDelegate?) {
        self.delegate = delegate
        
        super.init(routineDelegate: routineDelegate)
    }
    
    override var reuseIdentifier: String {
        return "ComboboxCell"
    }
    
    override var cellOwner: RoutineCellOwner {
        return .type(value: ComboboxCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding + self.combobox.textFieldViewModel.height
    }
    
}
