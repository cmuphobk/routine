import UIKit

protocol StandartModalViewDelegate: class {
    
    func didTriggerCloseModalAction(modal: StandartModalView)
    
}

class StandartModalView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: StandartModalViewDelegate?
    
    weak var modalContainer: UIView!
    
    private var privateBlurEffect: UIBlurEffect?
    var blurEffect: UIBlurEffect {
        
        get {
            if self.privateBlurEffect == nil {
                self.privateBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
            }
            return self.privateBlurEffect!
        }
        set {
            self.privateBlurEffect = newValue
        }
    }
    
    weak var blurView: UIVisualEffectView!
    
    private var animator: UIViewPropertyAnimator?
    
    private var privateBlurRadius: CGFloat?
    var blurRadius: CGFloat {
        get {
            
            if self.privateBlurRadius == nil {
                
                self.privateBlurRadius = 0.8
                
            }
            
            return self.privateBlurRadius!
            
        }
        set {
            
            self.privateBlurRadius = newValue
            
        }
    }
    
    private var privateGestureRecognizer: UIGestureRecognizer?
    private var gestureRecognizer: UIGestureRecognizer {
        
        if self.privateGestureRecognizer == nil {
            
            self.privateGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
            self.privateGestureRecognizer?.delegate = self
            
        }
        
        return self.privateGestureRecognizer!
        
    }
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contains = self.gestureRecognizers?.contains(self.gestureRecognizer)
        if contains != true {
            self.addGestureRecognizer(self.gestureRecognizer)
        }
        
        if self.blurView == nil {
            
            let blurView = UIVisualEffectView(effect: self.blurEffect)
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurView.alpha = 1.0
            blurView.backgroundColor = ColorProvider.default.clearColor
            
            self.blurView = blurView
            
            if !self.blurView.isDescendant(of: self) {
                self.addSubview(self.blurView)
            }
            
        }
        
        if self.modalContainer == nil {
        
            let modalContainer = UIView()
            
            modalContainer.backgroundColor = ColorProvider.default.whiteColor
            
            self.modalContainer = modalContainer
            
            if !self.modalContainer.isDescendant(of: self) {
                self.addSubview(self.modalContainer)
            }
        }
        
        if self.animator == nil {
            //Анимационный сборс blur effect остановленный на позиции 0.5 (https://habr.com/company/redmadrobot/blog/305596/)
            self.animator = UIViewPropertyAnimator(duration: 1, curve: .linear) {
                self.blurView.effect = nil
            }
        }
        
        blurView.frame = self.bounds
        self.blurView.effect = self.blurEffect

        self.animator?.fractionComplete = self.blurRadius
        
        let rectModalContainer = CGRect(x: self.frame.width * 0.1, y: self.frame.height * 0.2, width: self.frame.width - (self.frame.width * 0.2), height: self.frame.height - (self.frame.height * 0.4))
        let centerModalContainer = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        
        self.modalContainer.center = centerModalContainer
        self.modalContainer.frame = rectModalContainer
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.animator?.startAnimation()
        
    }
    
    deinit {
        self.animator?.stopAnimation(true)
        self.animator?.finishAnimation(at: .start)
        
        print("Deinit modal")
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let contains = self.gestureRecognizers?.contains(self.gestureRecognizer)
        if contains == true {
            self.removeGestureRecognizer(self.gestureRecognizer)
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        let contains = self.gestureRecognizers?.contains(self.gestureRecognizer)
        if contains != true {
            self.addGestureRecognizer(self.gestureRecognizer)
        }
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension StandartModalView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view == self.blurView {
            
            self.delegate?.didTriggerCloseModalAction(modal: self)
            
        }
        
        return true
    }
    
}
