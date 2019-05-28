import UIKit

final class WindowService: WindowServiceInterface {

    static let shared = WindowService()

    private init() {}

    private let screenHeightIphone5s: CGFloat = 568.0

    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

    var is5sAndLess: Bool {
        return self.screenHeight <= self.screenHeightIphone5s
    }

    var userInterfaceIdiom: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }

}
