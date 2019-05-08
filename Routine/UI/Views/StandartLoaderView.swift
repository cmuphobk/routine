import UIKit

// FIXME: - send to navigation?
// FIXME: - remove provider dependencies
extension UIWindow {
    
    func showLoaderView() {
        
        let loaderView = StandartLoaderView(frame: self.bounds)
        loaderView.tag = 10101
        self.addSubview(loaderView)
        
    }
    
    func hideLoaderView() {
        
        let loaderView = self.viewWithTag(10101)
        loaderView?.removeFromSuperview()
        
    }
    
}

class StandartLoaderView: UIView {
    
    // MARK: - Properties
    
    weak var loaderView: UIActivityIndicatorView!
    
    var blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
    
    weak var blurView: UIVisualEffectView!
    
    private var animator: UIViewPropertyAnimator?
    
    var blurRadius: CGFloat = 0.8
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        
        if self.blurView == nil {
            let blurView = UIVisualEffectView(effect: self.blurEffect)
            self.blurView = blurView
            
            if !self.blurView.isDescendant(of: self) {
                self.addSubview(self.blurView)
            }
        }
        
        if self.loaderView == nil {
            let loaderView = UIActivityIndicatorView(style: .whiteLarge)
            self.loaderView = loaderView
            
            if !self.loaderView.isDescendant(of: self) {
                self.addSubview(self.loaderView)
                self.loaderView.startAnimating()
            }
        }
        
        if self.animator == nil {
            //Анимационный сборс blur effect остановленный на позиции 0.5 (https://habr.com/company/redmadrobot/blog/305596/)
            self.animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
                self.blurView.effect = nil
            }
        }
        
        super.layoutSubviews()
        
        self.blurView.frame = self.bounds
        self.blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurView.alpha = 1.0
        self.blurView.backgroundColor = UIColor.clear
        self.blurView.effect = self.blurEffect
    
        self.animator?.fractionComplete = self.blurRadius
        
        let centerModalContainer = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.loaderView.color = ColorProvider.default.blueColor
        self.loaderView.center = centerModalContainer
        
    }
    
    deinit {
        
        self.animator?.stopAnimation(true)
        self.animator?.finishAnimation(at: .end)
        
        print("Deinit loader")
    }
    
}
