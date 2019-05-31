import UIKit

protocol RoutineLabelViewModel {
    associatedtype ViewModel: RoutineViewModel
    var viewModel: ViewModel { get set }
    var text: String { get set }
    var textColor: UIColor { get set }
    var font: UIFont { get set }
    var numberOfLines: Int { get set }
    init(viewModel: ViewModel,
         text: String,
         textColor: UIColor,
         font: UIFont,
         numberOfLines: Int)
}

extension RoutineLabelViewModel {
    
    init(viewModel: ViewModel,
         text: String,
         textColor: UIColor,
         font: UIFont,
         numberOfLines: Int) {
        self.viewModel = viewModel
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    func heightForWidth(_ width: CGFloat) -> CGFloat {
        let text = self.text
        let height = self.font.sizeOfStringLabel(string: text, constrainedToWidth: Double(width)).height
        return height
    }
}
