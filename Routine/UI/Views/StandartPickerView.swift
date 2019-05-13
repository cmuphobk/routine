import UIKit

protocol StandartPickerTitleModel {
    func toString(localizeService: StringServiceInterface) -> String 
}

protocol StandartPickerDelegate: class {
    
    func standartPickerView(_ pickerView: StandartPickerView, didSelectRow row: Int)
    func leftButtonAction(_ pickerView: StandartPickerView)
    func rightButtonAction(_ pickerView: StandartPickerView)
    
}

class StandartPickerView: RoutineView<RoutineViewModel>, UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate {
    
    weak var delegate: StandartPickerDelegate?
    
    var localizedService: StringServiceInterface
    
    private var models: [StandartPickerTitleModel]
    
    private var currentValue: String
    private var leftTitle: String
    private var rightTitle: String
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.white
        pickerView.layer.masksToBounds = false
        pickerView.dataSource = self
        pickerView.delegate = self
        
        if !pickerView.isDescendant(of: self) {
            self.addSubview(pickerView)
        }
        
        pickerView.frame = CGRect(x: 0.0, y: self.frame.height - 200.0, width: self.frame.width, height: 200.0)
        
        for (index, item) in self.models.enumerated() where item.toString(localizeService: self.localizedService) == self.currentValue {
            pickerView.selectRow(index, inComponent: 0, animated: false)
            break
        }
        
        return pickerView
    } ()
    
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
    
    init(models: [StandartPickerTitleModel],
         currentValue: String,
         frame: CGRect,
         delegate: StandartPickerDelegate,
         leftTitle: String,
         rightTitle: String,
         localizedService: StringServiceInterface) {
        
        self.delegate = delegate
        
        self.models = models
        
        self.currentValue = currentValue
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        
        self.localizedService = localizedService
        
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print(self.gestureRecognizer.description)
        print(self.blurView.description)
        print(self.pickerView.description)
        
        print(self.leftButton.description)
        print(self.rightButton.description)
        print(self.topBorderView.description)
        print(self.bottomBorderView.description)
        
        self.animator.fractionComplete = self.blurRadius
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.animator.stopAnimation(true)
        self.animator.finishAnimation(at: .start)
        
        print("StandartPickerView remove from memory")
    }
    
    func reloadData(models: [StandartPickerTitleModel]) {
        
        self.models = models
        
        self.pickerView.reloadAllComponents()
        
    }
    
    override func removeFromSuperview() {
        
        self.animator.stopAnimation(true)
        self.animator.finishAnimation(at: .start)
        
        super.removeFromSuperview()
    }
    
    // MARK: - UIPickerViewDataSource

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.models.count
        
    }

    // MARK: - UIPickerViewDelegate
    
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
        
        pickerView.text = self.viewModel.routineDelegate?.localize(self.models[row].toString(localizeService: self.localizedService))
        pickerView.font = FontProvider.default.standart
        pickerView.textAlignment = .center
        pickerView.textColor = UIColor.black
        pickerView.tag = row
        
        return pickerView
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.viewModel.routineDelegate?.localize(self.models[row].toString(localizeService: self.localizedService))
        
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view == self.blurView {
            
            self.delegate?.standartPickerView(self, didSelectRow: self.pickerView.selectedRow(inComponent: 0))
            
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
