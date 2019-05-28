import UIKit

class RoutineImageViewModel: RoutineViewModel {

    var image: UIImage                  = UIImage()
    var contentMode: UIView.ContentMode = .scaleAspectFill
    var width: CGFloat                  = 24.0
    var height: CGFloat                 = 24.0

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return self.height
    }
}
