import UIKit

protocol SingleButtonCellProtocol: class {
    func buttonDidPressed(sender: RoutineButton<RoutineButtonViewModel>)
}

final class SingleButtonCellViewModel: RoutineTableViewCellViewModel {
    var buttonConfiguration: RoutineButtonViewModel = RoutineButtonViewModel()
    weak var delegate: SingleButtonCellProtocol?
    
    init(delegate: SingleButtonCellProtocol?) {
        self.delegate = delegate
    }

    override var reuseIdentifier: String {
        return "SingleButtonCell"
    }
    
    override var cellOwner: RoutineCellOwner {
        return .type(value: SingleButtonCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding + self.buttonConfiguration.height
    }
    
}
