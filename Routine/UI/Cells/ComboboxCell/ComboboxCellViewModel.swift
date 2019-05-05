import UIKit

protocol ComboboxCellProtocol: class {
    func expand(viewModel: LocalizedComboboxViewModel)
}

final class ComboboxCellViewModel: LocalizedTableViewCellViewModel {
    var combobox: LocalizedComboboxViewModel = LocalizedComboboxViewModel()
    weak var delegate: ComboboxCellProtocol?
    
    init(delegate: ComboboxCellProtocol) {
        self.delegate = delegate
    }
    
    override var reuseIdentifier: String {
        return "ComboboxCell"
    }
    
    override var cellOwner: CellOwner {
        return .type(value: ComboboxCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding + self.combobox.textFieldViewModel.height
    }
    
}
