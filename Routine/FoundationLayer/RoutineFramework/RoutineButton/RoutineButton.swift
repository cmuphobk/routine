import UIKit
import Stevia

class RoutineButton<T: RoutineButtonViewModel>: UIButton, RoutineContainer, RoutineConfigure {
    
    typealias ViewModel = T
    
    var viewName: String?
    var viewModel: T!
        
    var didSetupConstraints: Bool = false
    
    init() {
        super.init(frame: CGRect.zero)
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        self.setTitle(AppDelegate.serviceProvider.makeStringService().localizeById(self.viewModel.text), for: .normal)
        self.setTitleColor(self.viewModel.textColor, for: .normal)
        self.titleLabel?.font = self.viewModel.font
        
        self.layer.borderColor = self.viewModel.borderColor.cgColor
        self.layer.borderWidth = self.viewModel.borderWidth
        
        self.contentMode = self.viewModel.contentMode
        
        if let image = self.viewModel.image {
            self.setImage(image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            self.tintColor = self.viewModel.tintColor
        }
        
    }
    
}
