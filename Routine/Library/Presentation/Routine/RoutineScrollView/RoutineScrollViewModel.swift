import UIKit

protocol RoutineScrollViewModel: RoutineViewModel {
    var contentInset: UIEdgeInsets { get set }
    init(viewName: String,
         backgroundColor: UIColor,
         cornerRadius: CGFloat,
         contentInset: UIEdgeInsets)
}

extension RoutineScrollViewModel {
    init(viewName: String,
         backgroundColor: UIColor,
         cornerRadius: CGFloat,
         contentInset: UIEdgeInsets) {
        self.init(viewName: viewName,
                  backgroundColor: backgroundColor,
                  cornerRadius: cornerRadius)
        self.contentInset = contentInset
    }
}
