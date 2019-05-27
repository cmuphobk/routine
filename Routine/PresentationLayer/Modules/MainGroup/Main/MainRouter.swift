import UIKit

final class MainRouter: BaseRouter {
    weak var viewController: UIViewController!
    weak var routerOutput: RouterOutput!
}

extension MainRouter: MainRouterInput {
    
    func rightSwipeAction() {
        self.routerOutput.openMenu()
    }
    
    func leftSwipeAction() {
        self.routerOutput.hideMenu()
    }
    
    @objc func menuButtonClicked() {
        self.routerOutput.triggerMenu()
    }
    
    func configureNavigationBar(title: String) {
        self.routerOutput.configureNavigationTitle(title)
        
        self.routerOutput.configureNavigationBarWithColor(ColorProvider.default.blueColor)
        
        self.routerOutput.customBarLeftButtonAction(
            icon: ImageProvider.default.menuIcon.imageWithMask(color: ColorProvider.default.whiteColor),
            target: self,
            action: #selector(menuButtonClicked))
    }
}
