import UIKit

protocol StandartPickerTitleModel {
    var title: String { get }
}

protocol StandartPickerDelegate: class {
    
    func standartPickerView(_ pickerView: StandartPickerView, didSelectRow row: Int)
    func leftButtonAction(_ pickerView: StandartPickerView)
    func rightButtonAction(_ pickerView: StandartPickerView)
    
}

class StandartPickerView: UIView {
    
    weak var delegate: StandartPickerDelegate?
    
    private var models: [StandartPickerTitleModel]
    
    private var currentValue: String
    private var leftTitle: String
    private var rightTitle: String
    
    weak var pickerView: UIPickerView!
    
    weak var leftButton: UIButton!
    weak var rightButton: UIButton!
    
    weak var topBorderView: UIView!
    weak var bottomBorderView: UIView!
    
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
    
    init(models: [StandartPickerTitleModel], currentValue: String, frame: CGRect, delegate: StandartPickerDelegate, leftTitle: String, rightTitle: String) {
        
        self.delegate = delegate
        
        self.models = models
        
        self.currentValue = currentValue
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contains = self.gestureRecognizers?.contains(self.gestureRecognizer)
        if contains != true {
            self.addGestureRecognizer(self.gestureRecognizer)
        }
        
        if self.blurView == blurView {
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
        
        if self.pickerView == nil {
            let pickerView = UIPickerView()
            pickerView.backgroundColor = ColorProvider.default.whiteColor
            pickerView.layer.masksToBounds = false
            pickerView.dataSource = self
            pickerView.delegate = self
            
            self.pickerView = pickerView
            
            if !self.pickerView.isDescendant(of: self) {
                self.addSubview(self.pickerView)
            }
            
        }
        
        self.pickerView.frame = CGRect(x: 0.0, y: self.frame.height - 200.0, width: self.frame.width, height: 200.0)
        
        for (index, item) in models.enumerated() where item.title == self.currentValue {
            self.pickerView.selectRow(index, inComponent: 0, animated: false)
            break
        }
        
        if self.leftButton == nil {
            
            let leftButton = UIButton()
            leftButton.backgroundColor = ColorProvider.default.whiteColor
            leftButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
            leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchDown)
            
            self.leftButton = leftButton
            
            if !self.leftButton.isDescendant(of: self) {
                self.addSubview(self.leftButton)
            }
        }
        
        self.leftButton.setTitle(self.leftTitle, for: .normal)
        self.leftButton.frame = CGRect(x: 0.0, y: self.frame.height - 240.0, width: self.frame.width / 2, height: 40.0)
        
        if self.rightButton == nil {
        
            let rightButton = UIButton()
            rightButton.backgroundColor = ColorProvider.default.whiteColor
            rightButton.setTitleColor(ColorProvider.default.blackColor, for: .normal)
            rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchDown)

            self.rightButton = rightButton
            
            if !self.rightButton.isDescendant(of: self) {
                self.addSubview(self.rightButton)
            }
        
        }
        
        self.rightButton.setTitle(self.rightTitle, for: .normal)
        self.rightButton.frame = CGRect(x: self.frame.width / 2, y: self.frame.height - 240.0, width: self.frame.width / 2, height: 40.0)
        
        
        if self.topBorderView == nil {
        
            let topBorderView = UIView()
            topBorderView.backgroundColor = ColorProvider.default.lightGrayColor
        
            self.topBorderView = topBorderView
            
            if !self.topBorderView.isDescendant(of: self) {
                self.addSubview(self.topBorderView)
            }
            
        }
        
        self.topBorderView.frame = CGRect(x: 0, y: self.frame.height - 240.0, width: self.frame.width, height: 1)
        
        if self.bottomBorderView == nil {
        
            let bottomBorderView = UIView()
            bottomBorderView.backgroundColor = ColorProvider.default.lightGrayColor
            
            self.bottomBorderView = bottomBorderView
            
            if !self.bottomBorderView.isDescendant(of: self) {
                self.addSubview(self.bottomBorderView)
            }
            
        }
        
        self.bottomBorderView.frame = CGRect(x: 0, y: self.frame.height - 200.0, width: self.frame.width, height: 1)
        
        
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
        self.animator?.stopAnimation(true)
        self.animator?.finishAnimation(at: .start)
        
        print("StandartPickerView remove from memory")
    }
    
    func reloadData(models: [StandartPickerTitleModel]) {
        
        self.models = models
        
        self.pickerView.reloadAllComponents()
        
    }
    
    override func removeFromSuperview() {
        
        self.animator?.stopAnimation(true)
        self.animator?.finishAnimation(at: .start)
        
        super.removeFromSuperview()
    }
    
}

// MARK: - UIPickerViewDataSource

extension StandartPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.models.count
        
    }
    
}

// MARK: - UIPickerViewDelegate

extension StandartPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 24.0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerView: UILabel!
        
        if let pickerLabel = view as? UILabel {
            
            pickerView = pickerLabel
            
        } else {
            
            pickerView = UILabel()
        }
        
        pickerView.text = AppDelegate.serviceProvider.makeStringService().localizeById(self.models[row].title)
        pickerView.font = FontProvider.default.standart
        pickerView.textAlignment = .center
        pickerView.textColor = ColorProvider.default.blackColor
        pickerView.tag = row
        
        return pickerView
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return AppDelegate.serviceProvider.makeStringService().localizeById(self.models[row].title)
        
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension StandartPickerView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view == self.blurView {
            
            self.delegate?.standartPickerView(self, didSelectRow: self.pickerView.selectedRow(inComponent: 0))
            
            self.removeFromSuperview()
            
        }
        
        return true
    }
    
}

// MARK: - Private

extension StandartPickerView {

    @objc func leftButtonAction() {
        self.delegate?.leftButtonAction(self)
    }

    @objc func rightButtonAction() {
        self.delegate?.rightButtonAction(self)
    }
}
