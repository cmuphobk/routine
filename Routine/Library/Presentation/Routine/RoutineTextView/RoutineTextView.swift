import UIKit
import Stevia

class RoutineTextView<T: RoutineTextViewModel>: UITextView, RoutineContainer {
    
    typealias ViewModel = T
    
    var viewName: String?
    var viewModel: T!
    
    var didSetupConstraints: Bool = false
    
    init() {
        super.init(frame: CGRect.zero, textContainer: nil)
        self.setupView()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.removeConstraints(self.constraints)
        
    }
    
    func setupLayout() {

    }
    
    func updateLayout() {
        
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if self.didSetupConstraints == false {
            self.didSetupConstraints = true
            
            self.setupLayout()
        }
        self.updateLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //always redraw
        self.setNeedsUpdateConstraints()
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.localizationSetup()
    }
    
    func localizationSetup() {
        
    }
    
    func setupViewModel() {
        
        self.backgroundColor = self.viewModel.backgroundColor
        self.layer.cornerRadius = self.viewModel.cornerRadius
        
        self.returnKeyType = self.viewModel.returnKeyType
        
        let text = self.viewModel.routineDelegate?.localize(self.viewModel.text) ?? self.viewModel.text
        self.text = text
        self.textColor = self.viewModel.textColor
        self.font = self.viewModel.font
        
    }
    
}
