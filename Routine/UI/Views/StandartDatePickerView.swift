import UIKit

protocol StandartDatePickerViewDelegate: class {
    
    func standartDatePickerViewDelegate(_ datePickerView: StandartDatePickerView, didSelectDate date: Date)
    func leftButtonAction(_ pickerView: StandartDatePickerView)
    func rightButtonAction(_ pickerView: StandartDatePickerView)
    
}

class StandartDatePickerView: RoutineView<RoutineViewModel>, UIGestureRecognizerDelegate {
    
    var languageService: LanguageServiceInterface!
    
    weak var delegate: StandartDatePickerViewDelegate?
    
    lazy private var datePickerView: UIDatePicker = {
       
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = self.datePickerMode
        datePickerView.locale = Locale(identifier: self.languageService.currentLanguage().code)
        datePickerView.backgroundColor = UIColor.white
        datePickerView.layer.masksToBounds = false
        datePickerView.setValue(UIColor.black, forKeyPath: "textColor")
        datePickerView.setValue(false, forKey: "highlightsToday")
        datePickerView.subviews[0].subviews[1].backgroundColor = UIColor.white
        datePickerView.subviews[0].subviews[2].backgroundColor = UIColor.white
        datePickerView.frame = CGRect(x: 0.0, y: self.frame.height - 200.0, width: self.frame.width, height: 200.0)
        
        if !datePickerView.isDescendant(of: self) {
            self.addSubview(datePickerView)
        }
        
        return datePickerView
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.prominent))
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.alpha = 1.0
        blurView.backgroundColor = UIColor.clear
        
        if !blurView.isDescendant(of: self) {
            self.addSubview(blurView)
        }
        return blurView
    }()
    
    lazy var leftButton: UIButton = {
        let leftButton = UIButton()
        leftButton.backgroundColor = UIColor.white
        leftButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
        leftButton.setTitle(self.leftTitle, for: .normal)
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchDown)
        leftButton.frame = CGRect(x: 0.0, y: self.frame.height - 240.0, width: self.frame.width / 2, height: 40.0)
        
        if !leftButton.isDescendant(of: self) {
            self.addSubview(leftButton)
        }
        
        return leftButton
    }()
    
    lazy var rightButton: UIButton = {
        let rightButton = UIButton()
        rightButton.backgroundColor = UIColor.white
        rightButton.setTitleColor(UIColor.black, for: .normal)
        rightButton.setTitle(self.rightTitle, for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchDown)
        rightButton.frame = CGRect(x: self.frame.width / 2, y: self.frame.height - 240.0, width: self.frame.width / 2, height: 40.0)
        
        if !rightButton.isDescendant(of: self) {
            self.addSubview(rightButton)
        }
        
        return rightButton
    }()
    
    lazy var topBorderView: UIView = {
        let topBorderView = UIView()
        topBorderView.backgroundColor = ColorProvider.default.lightGrayColor
        topBorderView.frame = CGRect(x: 0, y: self.frame.height - 240.0, width: self.frame.width, height: 1)
        
        if !topBorderView.isDescendant(of: self) {
            self.addSubview(topBorderView)
        }
        
        return topBorderView
    }()
    
    lazy var bottomBorderView: UIView = {
        let bottomBorderView = UIView()
        bottomBorderView.backgroundColor = ColorProvider.default.lightGrayColor
        bottomBorderView.frame = CGRect(x: 0, y: self.frame.height - 200.0, width: self.frame.width, height: 1)
        
        if !bottomBorderView.isDescendant(of: self) {
            self.addSubview(bottomBorderView)
        }
        return bottomBorderView
    }()
    
    var date: Date {
        return self.datePickerView.date
    }
    
    private var leftTitle: String
    private var rightTitle: String
    var datePickerMode: UIDatePicker.Mode
    
    //Анимационный сборс blur effect остановленный на позиции blurRadius (https://habr.com/company/redmadrobot/blog/305596/)
    private lazy var animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
        self.blurView.effect = nil
    }
    
    var blurRadius: CGFloat = 0.8
    
    private lazy var gestureRecognizer = { () -> UITapGestureRecognizer in
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
        gestureRecognizer.delegate = self
        
        let contains = self.gestureRecognizers?.contains(gestureRecognizer)
        if contains != true {
            self.addGestureRecognizer(gestureRecognizer)
        }
        
        return gestureRecognizer
    }()
    
    init(frame: CGRect,
         delegate: StandartDatePickerViewDelegate,
         leftTitle: String,
         rightTitle: String,
         datePickerMode: UIDatePicker.Mode = .date,
         languageService: LanguageServiceInterface) {
        
        self.languageService = languageService
        
        self.delegate = delegate
        
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        self.datePickerMode = datePickerMode
        
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print(self.gestureRecognizer.description)
        print(self.blurView.description)
        print(self.topBorderView.description)
        print(self.bottomBorderView.description)
        print(self.leftButton.description)
        print(self.rightButton.description)
        print(self.datePickerView.description)
        
        self.animator.fractionComplete = self.blurRadius
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("StandartDatePickerView remove from memory")
    }
    
    override func removeFromSuperview() {
        
        self.animator.stopAnimation(true)
        self.animator.finishAnimation(at: .start)
        
        super.removeFromSuperview()
    }

    // MARK: - UIGestureRecognizerDelegate

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view == self.blurView {
            
            self.delegate?.standartDatePickerViewDelegate(self, didSelectDate: self.datePickerView.date)
            
            self.removeFromSuperview()
            
        }
        
        return true
    }

    // MARK: - Private
    
    @objc func leftButtonAction() {
        self.delegate?.leftButtonAction(self)
    }
    
    @objc func rightButtonAction() {
        self.delegate?.rightButtonAction(self)
    }
}
