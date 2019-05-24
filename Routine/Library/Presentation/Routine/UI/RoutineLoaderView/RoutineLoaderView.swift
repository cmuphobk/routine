import UIKit

//FIXME: ViewModel
class RoutineLoaderView: RoutineView<RoutineViewModel> {
    
    // MARK: - Properties
    
    lazy var loaderView: UIActivityIndicatorView = {
        let loaderView = UIActivityIndicatorView(style: .whiteLarge)
        
        if !loaderView.isDescendant(of: self) {
            self.addSubview(loaderView)
            loaderView.startAnimating()
        }
        return loaderView
    }()
    
    var blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
    
    lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: self.blurEffect)
        
        if !blurView.isDescendant(of: self) {
            self.addSubview(blurView)
        }
        return blurView
    }()
    
    lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.blurView.effect = nil
        }
    }()
    
    var blurRadius: CGFloat = 0.8
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.blurView.frame = self.bounds
        self.blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurView.alpha = 1.0
        self.blurView.backgroundColor = UIColor.clear
        self.blurView.effect = self.blurEffect
    
        self.animator.fractionComplete = self.blurRadius
        
        self.loaderView.color = ColorProvider.default.blueColor
        self.loaderView.center =  CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        
    }
    
    deinit {
        self.animator.stopAnimation(true)
        self.animator.finishAnimation(at: .end)
        
        print("Deinit loader")
    }
    
}
