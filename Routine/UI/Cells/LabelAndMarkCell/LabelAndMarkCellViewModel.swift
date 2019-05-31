import Foundation
import UIKit

final class LabelAndMarkCellViewModel: RoutineTableViewCellViewModel {
    lazy var label: RoutineLabelViewModel = RoutineLabelViewModel()
    lazy var image: RoutineImageViewModel = RoutineImageViewModel()
    var betweenSpace: CGFloat = 8.0

    override var reuseIdentifier: String {
        return "LabelAndMarkCellViewModel"
    }

    override var cellOwner: RoutineCellOwner {
        return .type(value: LabelAndMarkCell.self)
    }

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return 52
    }
}
