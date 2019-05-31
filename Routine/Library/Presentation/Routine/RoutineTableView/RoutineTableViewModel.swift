import UIKit

protocol RoutineTableViewModel: RoutineScrollViewModel {
    var separatorStyle: UITableViewCell.SeparatorStyle { get set }
    init(viewName: String,
         backgroundColor: UIColor,
         cornerRadius: CGFloat,
         separatorStyle: UITableViewCell.SeparatorStyle)
}

extension RoutineTableViewModel {
    init(viewName: String,
         backgroundColor: UIColor,
         cornerRadius: CGFloat,
         separatorStyle: UITableViewCell.SeparatorStyle) {
        self.init(viewName: viewName,
                  backgroundColor: backgroundColor,
                  cornerRadius: cornerRadius)
        self.separatorStyle = separatorStyle
    }
}
