import UIKit

class RoutineViewModel: RoutineHeightable {

    let uuid: String = NSUUID().uuidString
    var viewName: String = ""

    weak var routineDelegate: RoutineDelegate?

    var backgroundColor: UIColor = UIColor.white
    var cornerRadius: CGFloat = 0.0
    var paddingViewCornerRadius: CGFloat = 0.0

    var paddingOffsets = PaddingOffsets(top: 0.0, bottom: 0.0, left: 0.0, right: 0.0)

    var leftAndRightPadding: CGFloat {
        return self.paddingOffsets.left + self.paddingOffsets.right
    }

    var topAndBottomPadding: CGFloat {
        return self.paddingOffsets.top + self.paddingOffsets.bottom
    }

    func heightForWidth(_ width: CGFloat) -> CGFloat {
        return 0.0
    }

    init(routineDelegate: RoutineDelegate?) {
        self.routineDelegate = routineDelegate
    }
}

// MARK: - Equatable
extension RoutineViewModel: Equatable {

    static func == (left: RoutineViewModel, right: RoutineViewModel) -> Bool {
        return left.uuid == right.uuid
    }

}
