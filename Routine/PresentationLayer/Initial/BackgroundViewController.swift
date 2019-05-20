//import UIKit
//

//
//// MARK: - Properties
//final class BackgroundViewController: UIViewController {
//    
//    private let kMenuViewWidth: CGFloat = 300.0
//    
//    var moduleService: ModuleServiceInterface!
//    var windowService: WindowServiceInterface!
//    
//    var initialNavigationController: UINavigationController!
//    var menuModuleViewController: UIViewController!
//    var currentViewController: UIViewController?
//    var animateLaunchScreenViewController: AnimateLaunchScreenViewController!
//    
//    var menuModuleInput: MenuModuleInput!
//    
//    var statusHeight: CGFloat!
//    var navHeight: CGFloat!
//    var statusNavHeight: CGFloat!
//    var modulesStack: [UIViewController] = []
//    
//    var errorLabel: StandartOffsetLabel!
//    var errorImageView: UIImageView!
//    
//    var taskHideError: DispatchWorkItem!
//
//}
//
//// MARK: - LifeCycle
//extension BackgroundViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let moduleBeforeLaunchName = self.configureNavigationController()
//        
//        self.configureMenu()
//        
//        self.configureAnimationLaunch(moduleBeforeLaunchName: moduleBeforeLaunchName)
//        
//    }
//}
//
//// MARK: - MenuModuleOutput
//extension BackgroundViewController: MenuModuleOutput {
//    
//}
//
//
//
//// MARK: - Private
////extension BackgroundViewController {
////
////    private func configureNavigationController() -> String {
////
////        guard let moduleBeforeLaunch = self.obtainModuleBeforeLaunch() else { abort() }
////
////        self.initialNavigationController = UINavigationController()
////        self.initialNavigationController.view.frame = self.view.bounds
////        self.view.addSubview(self.initialNavigationController.view)
////        self.addChild(self.initialNavigationController)
////
////        self.moduleService.navigation = self
////
////        self.statusHeight = UIApplication.shared.statusBarFrame.height
////        self.navHeight = self.initialNavigationController.navigationBar.frame.height
////        self.statusNavHeight = self.statusHeight + self.navHeight
////
////        self.openModule(moduleBeforeLaunch)
////
////        return moduleBeforeLaunch.name
////
////    }
////
////    private func configureAnimationLaunch(moduleBeforeLaunchName: String) {
////
////        self.animateLaunchScreenViewController = R.storyboard.animateLaunchScreenViewController.animateLaunchScreenViewController()
////
////        self.updateProgressToValue(1.0)
////
////        if let viewController = self.animateLaunchScreenViewController {
////            guard let view = viewController.view else { return }
////            self.addChild(viewController)
////            view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
////            self.view.addSubview(view)
////            self.updateProgressToValue(0)
////        }
////
////    }
////
////    private func configureMenu() {
////
////        self.moduleService.moduleFactory.makeMenuModule(moduleOutput: self) { [unowned self] (viewController: UIViewController?, moduleInput: MenuModuleInput?) in
////
////            self.menuModuleInput = moduleInput
////            self.menuModuleInput.configureModule(menuItems: self.moduleService.obtainAvailableModulesAndActionsIds())
////
////            if let viewController = viewController {
////                guard let view = viewController.view else { return }
////                self.addChild(viewController)
////                view.frame = CGRect(x: -self.kMenuViewWidth, y: 0, width: self.kMenuViewWidth, height: self.view.frame.height)
////                self.view.addSubview(view)
////                self.menuModuleViewController = viewController
////            }
////
////        }
////
////    }
////
////    private func obtainModuleBeforeLaunch() -> Module? {
////
////        let moduleId = self.moduleService.obtainModuleIdBeforeLaunch()
////        var module: Module?
////
////        switch moduleId {
////        case kMainModuleId:
////
////            self.moduleService.moduleFactory.makeMainModule { (_, mainModuleInput) in
////                module = mainModuleInput as? Module
////            }
////
////        default:
////            module = nil
////        }
////
////        return module
////    }
////
////    private func updateProgressToValue(_ progress: Float) {
////
////        self.animateLaunchScreenViewController?.updateProgress(progress)
////
////        if self.animateLaunchScreenViewController.progress >= 1.0 {
////
////            UIView.animate(withDuration: 0.5, animations: {
////                self.animateLaunchScreenViewController.view.alpha = 0.0
////            }, completion: { [unowned self] _ in
////                self.animateLaunchScreenViewController.view.removeFromSuperview()
////                self.animateLaunchScreenViewController.removeFromParent()
////            })
////
////            return
////        }
////
////    }
////
////    private func updateProgress() {
////
////        self.animateLaunchScreenViewController?.updateProgress(self.animateLaunchScreenViewController.progress + 0.15)
////
////        if self.animateLaunchScreenViewController.progress >= 1.0 {
////
////            UIView.animate(withDuration: 0.5, animations: {
////                self.animateLaunchScreenViewController.view.alpha = 0.0
////            }, completion: { [unowned self] _ in
////                self.animateLaunchScreenViewController.view.removeFromSuperview()
////                self.animateLaunchScreenViewController.removeFromParent()
////            })
////
////            return
////        }
////
////        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: self.updateProgress)
////
////    }
////
////    @objc private func errorLabelTapEvent(gestureRecognizer: UIGestureRecognizer) {
////
////        self.hideMessages()
////
////    }
////
////}
