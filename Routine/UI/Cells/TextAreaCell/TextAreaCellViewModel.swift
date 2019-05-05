import UIKit

protocol TextAreaCellProtocol: class {
    func textBeginEdited(object: LocalizedTextViewModel)
    func textChanged(object: LocalizedTextViewModel, newValue: String)
}

final class TextAreaCellViewModel: LocalizedTableViewCellViewModel {
    var textAreaConfiguration: LocalizedTextViewModel = LocalizedTextViewModel()
    weak var delegate: TextAreaCellProtocol?
    
    init(delegate: TextAreaCellProtocol) {
        self.delegate = delegate
    }
    
    override var reuseIdentifier: String {
        return "TextAreaCell"
    }
    
    override var cellOwner: CellOwner {
        return .type(value: TextAreaCell.self)
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.topAndBottomPadding + self.textAreaConfiguration.height
    }

}
