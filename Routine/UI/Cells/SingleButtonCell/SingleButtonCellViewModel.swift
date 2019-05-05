import UIKit

protocol SingleButtonCellProtocol: class {
    func buttonDidPressed(sender: LocalizedButton<LocalizedButtonViewModel>)
}

final class SingleButtonCellViewModel: LocalizedTableViewCellViewModel {
    var buttonConfiguration: LocalizedButtonViewModel = LocalizedButtonViewModel()
    weak var delegate: SingleButtonCellProtocol?
    
    init(delegate: SingleButtonCellProtocol?) {
        self.delegate = delegate
    }

    override var reuseIdentifier: String {
        return "SingleButtonCell"
    }
    
    override var cellOwner: CellOwner {
        return .type(value: SingleButtonCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding + self.buttonConfiguration.height
    }
    
}
