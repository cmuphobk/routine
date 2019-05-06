import UIKit
import Stevia

class RoutineTextView<T: RoutineTextViewModel>: UITextView, RoutineContainer, RoutineConfigure {
    
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
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.localizationSetup()
    }
    
    func localizationSetup() {
        
    }
    
    func configureView(config: T) {
        
        self.viewModel = config
        self.viewName = config.viewName
        
        self.configure()
        self.setNeedsUpdateConstraints()
        
    }
    
    func configureView(config: AnyObject) {
        if config.isKind(of: T.self) {
            guard let config = config as? T else { return }
            self.configureView(config: config)
        }
    }
    
    private func configure() {
        
        self.backgroundColor = self.viewModel.backgroundColor
        self.layer.cornerRadius = self.viewModel.cornerRadius
        
        self.returnKeyType = self.viewModel.returnKeyType
        self.text = AppDelegate.serviceProvider.makeStringService().localizeById(self.viewModel.text)
        self.textColor = self.viewModel.textColor
        self.font = self.viewModel.font
        
    }
    
}
