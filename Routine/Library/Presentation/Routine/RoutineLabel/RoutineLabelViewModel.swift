import UIKit

class RoutineLabelViewModel: RoutineViewModel {

    var text: String = ""
    var textColor: UIColor = UIColor.black
    var font: UIFont  = UIFont.systemFont(ofSize: 12.00)
    var numberOfLines = 1

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let text = self.routineDelegate?.localize(self.text) ?? self.text
        let height = self.font.sizeOfStringLabel(string: text, constrainedToWidth: Double(width)).height
        return height
    }
}
