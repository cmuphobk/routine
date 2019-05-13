import UIKit

protocol SingleButtonCellProtocol: class {
    func buttonDidPressed(sender: RoutineButton<RoutineButtonViewModel>)
}

final class SingleButtonCellViewModel: RoutineTableViewCellViewModel {
    lazy var buttonConfiguration: RoutineButtonViewModel = RoutineButtonViewModel(routineDelegate: self.routineDelegate)
    weak var delegate: SingleButtonCellProtocol?
    
    init(delegate: SingleButtonCellProtocol?, routineDelegate: RoutineDelegate?) {
        self.delegate = delegate
        
        super.init(routineDelegate: routineDelegate)
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
