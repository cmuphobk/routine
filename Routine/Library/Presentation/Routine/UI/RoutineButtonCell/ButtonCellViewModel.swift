import UIKit

protocol ButtonCellProtocol: class {
    func buttonDidPressed(sender: RoutineButton<RoutineButtonViewModel>)
}

final class ButtonCellViewModel: RoutineTableViewCellViewModel {
    lazy var buttonViewModel: RoutineButtonViewModel = RoutineButtonViewModel(routineDelegate: self.routineDelegate)
    weak var delegate: ButtonCellProtocol?

    init(delegate: ButtonCellProtocol?, routineDelegate: RoutineDelegate?) {
        self.delegate = delegate

        super.init(routineDelegate: routineDelegate)
    }

    override var reuseIdentifier: String {
        return "SingleButtonCell"
    }

    override var cellOwner: RoutineCellOwner {
        return .type(value: ButtonCell.self)
    }

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding + self.buttonViewModel.height
    }

}
