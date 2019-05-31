import UIKit

protocol RoutineHeightable {
    func heightForWidth(_ width: CGFloat) -> CGFloat
}

protocol RoutineViewNamed {
    var viewName: String { get set }
}

protocol RoutineViewModel: RoutineViewNamed, RoutineHeightable {
    var uuid: String { get }
    var backgroundColor: UIColor { get set }
    var cornerRadius: CGFloat { get set }
    init(viewName: String,
         backgroundColor: UIColor,
         cornerRadius: CGFloat)
}

extension RoutineViewModel {
    var uuid: String {
        return UUID().uuidString
    }
    init(viewName: String,
         backgroundColor: UIColor,
         cornerRadius: CGFloat) {
        self.viewName = viewName
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
    }
}

struct RoutineBaseViewModel: RoutineViewModel {
    var backgroundColor: UIColor
    var cornerRadius: CGFloat
    var viewName: String
    func heightForWidth(_ width: CGFloat) -> CGFloat {
        return 0.0
    }
}
