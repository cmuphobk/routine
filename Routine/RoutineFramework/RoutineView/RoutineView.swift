import UIKit
import Stevia

class RoutineView<T: RoutineViewModel>: UIView, RoutineContainer {
    
    typealias ViewModel = T
    
    var viewName: String?
    var viewModel: T!
    
    weak var paddingView: UIView!
    
    var didSetupConstraints: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        let paddingView = UIView(frame: CGRect.zero)
        self.sv(
            paddingView
        )
        self.paddingView = paddingView
        
        self.removeConstraints(self.constraints)
        
    }
    
    func setupLayout() {
        
        layout(
            self.viewModel.paddingOffsets.top,
            |-self.viewModel.paddingOffsets.left-self.paddingView-self.viewModel.paddingOffsets.right-|,
            self.viewModel.paddingOffsets.bottom
        )
        
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
        self.paddingView.layer.cornerRadius = self.viewModel.paddingViewCornerRadius
        self.paddingView.clipsToBounds = true
        
    }
}
