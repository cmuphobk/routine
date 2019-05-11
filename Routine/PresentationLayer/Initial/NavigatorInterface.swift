import UIKit

protocol NavigatorInterface {
    
    func triggerMenu()
    func openMenu()
    func hideMenu()
    
    func openModule(_ module: Module)
    func openModuleFromLeft(_ module: Module)
    func pushModule(_ module: Module)
    func popModule()
    func popModule(_ countPops: Int)
    
    func showMessageWithText(_ text: String, andType type: MessageType)
    func showMessageWithText(_ text: String, andType type: MessageType, sender: Any?)
    
    func hideMessages()
    
    func containerForModal() -> ModalContainer?
    
    func addChild(_ viewController: UIViewController)
    func removeFromParent()
    
    func emptyCustomBarLeftButtonAction()
    func customBarLeftButtonAction(icon: UIImage, action: Selector)
    func customBarRightButtonAction(icon: UIImage, action: Selector)
    func customBarLeftTextButtonAction(text: String, action: Selector)
    func customBarRightTextButtonAction(text: String, action: Selector)
    
    func configureTransparentNavigationBar()
    func configureNavigationBarWithColor(_ color: UIColor) 
    
}
