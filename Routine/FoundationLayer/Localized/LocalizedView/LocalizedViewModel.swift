import UIKit

class LocalizedViewModel: LocalizableHeightable {
    
    let uuid: String = NSUUID().uuidString
    var viewName: String = ""
    
    var backgroundColor: UIColor = UIColor.white
    var cornerRadius: CGFloat = 0.0
    var paddingViewCornerRadius: CGFloat = 0.0
    
    var paddingOffsets = Offsets(top: 0.0, bottom: 0.0, left: 0.0, right: 0.0)
    
    var leftAndRightPadding: CGFloat {
        return self.paddingOffsets.left + self.paddingOffsets.right
    }
    
    var topAndBottomPadding: CGFloat {
        return self.paddingOffsets.top + self.paddingOffsets.bottom
    }
    
    func heightForWidth(_ width: CGFloat) -> CGFloat {
        return 0.0
    }
    
}

// MARK: - Equatable
extension LocalizedViewModel: Equatable {
    
    static func == (left: LocalizedViewModel, right: LocalizedViewModel) -> Bool {
        return left.uuid == right.uuid
    }
    
}
