import UIKit

//FIXME: send to service
extension UIViewController {
    
    func emptyCustomBarLeftButtonAction() {

        AppDelegate.serviceProvider.makeModuleService().navigation?.hideMenu()
        
        let emptyLeftBarButtonCustom = UIButton(type: .custom)
        emptyLeftBarButtonCustom.isUserInteractionEnabled = false
        emptyLeftBarButtonCustom.alpha = 0.0
        emptyLeftBarButtonCustom.isHidden = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: emptyLeftBarButtonCustom)
        
    }
    
    func customBarLeftButtonAction(icon: UIImage, action: Selector) {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.emptyCustomBarLeftButtonAction()
            AppDelegate.serviceProvider.makeModuleService().navigation?.openMenu()
            return
        }
        
        let leftBarButtonCustom = UIButton(type: .custom)
        leftBarButtonCustom.backgroundColor = ColorProvider.default.clearColor
        leftBarButtonCustom.frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
        leftBarButtonCustom.setImage(icon, for: .normal)
        leftBarButtonCustom.addTarget(self, action: action, for: .touchDown)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonCustom)
        
    }
    
    func customBarRightButtonAction(icon: UIImage, action: Selector) {
        let rightBarButtonCustom = UIButton(type: .custom)
        rightBarButtonCustom.backgroundColor = ColorProvider.default.clearColor
        rightBarButtonCustom.frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
        rightBarButtonCustom.setImage(icon, for: .normal)
        rightBarButtonCustom.addTarget(self, action: action, for: .touchDown)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonCustom)
    }

    func customBarLeftTextButtonAction(text: String, action: Selector) {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.emptyCustomBarLeftButtonAction()
            AppDelegate.serviceProvider.makeModuleService().navigation?.openMenu()
            return
        }
        
        let leftBarButtonCustom = UIButton(type: .custom)
        
        leftBarButtonCustom.setTitle(text, for: .normal)
        leftBarButtonCustom.backgroundColor = ColorProvider.default.clearColor
        leftBarButtonCustom.frame = CGRect(x: 0.0, y: 0.0, width: leftBarButtonCustom.intrinsicContentSize.width, height: 32.0)
        leftBarButtonCustom.addTarget(self, action: action, for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonCustom)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            AppDelegate.serviceProvider.makeModuleService().navigation?.openMenu()
        }
    }
    
    func customBarRightTextButtonAction(text: String, action: Selector) {
        let rightBarButtonCustom = UIButton(type: .custom)
        
        rightBarButtonCustom.setTitle(text, for: .normal)
        rightBarButtonCustom.backgroundColor = ColorProvider.default.clearColor
        rightBarButtonCustom.frame = CGRect(x: 0.0, y: 0.0, width: rightBarButtonCustom.intrinsicContentSize.width, height: 32.0)
        rightBarButtonCustom.addTarget(self, action: action, for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonCustom)
    }
    
}
