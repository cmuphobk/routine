import UIKit

protocol RoutineCollectionViewCellViewModel {
    associatedtype ViewModel: RoutineViewModel
    var viewModel: ViewModel { get set }
    var reuseIdentifier: String { get set }

    var cellOwner: RoutineCellOwner { get set }
    var isSelected: Bool { get set }
    var backgroundViewModel: ViewModel { get set }

    var width: CGFloat { get set }

    init(viewModel: ViewModel,
         reuseIdentifier: String,
         cellOwner: RoutineCellOwner,
         isSelected: Bool,
         backgroundViewModel: ViewModel,
         width: CGFloat)
}

extension RoutineCollectionViewCellViewModel {
    init(viewModel: ViewModel,
         reuseIdentifier: String,
         cellOwner: RoutineCellOwner,
         isSelected: Bool,
         backgroundViewModel: ViewModel,
         width: CGFloat) {
        self.viewModel = viewModel
        self.reuseIdentifier = reuseIdentifier
        self.cellOwner = cellOwner
        self.isSelected = isSelected
        self.backgroundViewModel = backgroundViewModel
        self.width = width
    }
}
