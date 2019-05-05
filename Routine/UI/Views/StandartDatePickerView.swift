import UIKit

protocol StandartDatePickerViewDelegate: class {
    
    func standartDatePickerViewDelegate(_ datePickerView: StandartDatePickerView, didSelectDate date: Date)
    func leftButtonAction(_ pickerView: StandartDatePickerView)
    func rightButtonAction(_ pickerView: StandartDatePickerView)
    
}

class StandartDatePickerView: UIView {
    
    var languageService: LanguageServiceInterface!
    
    weak var delegate: StandartDatePickerViewDelegate?
    
    weak private var datePickerView: UIDatePicker!
    
    weak var blurView: UIVisualEffectView!
    
    weak var leftButton: UIButton!
    weak var rightButton: UIButton!
    
    weak var topBorderView: UIView!
    weak var bottomBorderView: UIView!
    
    var date: Date {
        return self.datePickerView.date
    }
    
    private var leftTitle: String
    private var rightTitle: String
    var datePickerMode: UIDatePicker.Mode
    
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
    
    init(frame: CGRect, delegate: StandartDatePickerViewDelegate, leftTitle: String, rightTitle: String, datePickerMode: UIDatePicker.Mode = .date) {
        
        self.languageService = AppDelegate.serviceProvider.makeLanguageService()
        
        self.delegate = delegate
        
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        self.datePickerMode = datePickerMode
        
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contains = self.gestureRecognizers?.contains(self.gestureRecognizer)
        if contains != true {
            self.addGestureRecognizer(self.gestureRecognizer)
        }
        
        if self.blurView == nil {
            
            let blurView = UIVisualEffectView(effect: self.blurEffect)
            blurView.frame = self.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurView.alpha = 1.0
            blurView.backgroundColor = ColorProvider.default.clearColor
            
            self.blurView = blurView
            
            if !self.blurView.isDescendant(of: self) {
                self.addSubview(self.blurView)
            }
        }
        
        
        if self.topBorderView == nil {
            let topBorderView = UIView()
            topBorderView.backgroundColor = ColorProvider.default.lightGrayColor
            topBorderView.frame = CGRect(x: 0, y: self.frame.height - 240.0, width: self.frame.width, height: 1)
            
            self.topBorderView = topBorderView
            
            if !self.topBorderView.isDescendant(of: self) {
                self.addSubview(self.topBorderView)
            }
        }
        
        if self.bottomBorderView == nil {
            let bottomBorderView = UIView()
            bottomBorderView.backgroundColor = ColorProvider.default.lightGrayColor
            bottomBorderView.frame = CGRect(x: 0, y: self.frame.height - 200.0, width: self.frame.width, height: 1)
            
            self.bottomBorderView = bottomBorderView
            
            if !self.bottomBorderView.isDescendant(of: self) {
                self.addSubview(self.bottomBorderView)
            }
        }
        
        if self.leftButton == nil {
            let leftButton = UIButton()
            leftButton.backgroundColor = ColorProvider.default.whiteColor
            leftButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
            leftButton.setTitle(self.leftTitle, for: .normal)
            leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchDown)
            leftButton.frame = CGRect(x: 0.0, y: self.frame.height - 240.0, width: self.frame.width / 2, height: 40.0)
           
            self.leftButton = leftButton
            
            if !self.leftButton.isDescendant(of: self) {
                self.addSubview(self.leftButton)
            }
        }
        
        if self.rightButton == nil {
            let rightButton = UIButton()
            rightButton.backgroundColor = ColorProvider.default.whiteColor
            rightButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
            rightButton.setTitle(self.rightTitle, for: .normal)
            rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchDown)
            rightButton.frame = CGRect(x: self.frame.width / 2, y: self.frame.height - 240.0, width: self.frame.width / 2, height: 40.0)
            
            self.rightButton = rightButton
        
            if !self.rightButton.isDescendant(of: self) {
                self.addSubview(self.rightButton)
            }
        }
        
        if self.datePickerView == nil {
            let datePickerView = UIDatePicker()
            datePickerView.datePickerMode = self.datePickerMode
            datePickerView.locale = Locale(identifier: self.languageService.currentLanguage().code)
            datePickerView.backgroundColor = ColorProvider.default.whiteColor
            datePickerView.layer.masksToBounds = false
            datePickerView.setValue(ColorProvider.default.blackColor, forKeyPath: "textColor")
            datePickerView.setValue(false, forKey: "highlightsToday")
            datePickerView.subviews[0].subviews[1].backgroundColor = ColorProvider.default.whiteColor
            datePickerView.subviews[0].subviews[2].backgroundColor = ColorProvider.default.whiteColor
            datePickerView.frame = CGRect(x: 0.0, y: self.frame.height - 200.0, width: self.frame.width, height: 200.0)
            
            self.datePickerView = datePickerView
            
            if !self.datePickerView.isDescendant(of: self) {
                self.addSubview(self.datePickerView)
            }
        }
        
        if self.animator == nil {
            //Анимационный сборс blur effect остановленный на позиции 0.5 (https://habr.com/company/redmadrobot/blog/305596/)
            self.animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
                self.blurView.effect = nil
            }
        }
        
        self.blurView.effect = self.blurEffect
        
        self.animator?.fractionComplete = self.blurRadius
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("StandartDatePickerView remove from memory")
    }
    
    override func removeFromSuperview() {
        
        self.animator?.stopAnimation(true)
        self.animator?.finishAnimation(at: .start)
        
        super.removeFromSuperview()
    }
}

// MARK: - UIGestureRecognizerDelegate

extension StandartDatePickerView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view == self.blurView {
            
            self.delegate?.standartDatePickerViewDelegate(self, didSelectDate: self.datePickerView.date)
            
            self.removeFromSuperview()
            
        }
        
        return true
    }
    
}

// MARK: - Private

extension StandartDatePickerView {
    
    @objc func leftButtonAction() {
        self.delegate?.leftButtonAction(self)
    }
    
    @objc func rightButtonAction() {
        self.delegate?.rightButtonAction(self)
    }
}
