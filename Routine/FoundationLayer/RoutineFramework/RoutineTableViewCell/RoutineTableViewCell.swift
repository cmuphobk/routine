import UIKit
import Stevia

class RoutineTableViewCell<T: RoutineTableViewCellViewModel>: UITableViewCell, RoutineContainer {
    
    typealias ViewModel = T
    
    var viewName: String?
    var viewModel: T!
    
    weak var paddingView: UIView!
    
    var didSetupConstraints: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupView()
        
    }
    
    func setupView() {
        
        let paddingView = UIView(frame: CGRect.zero)
        self.contentView.sv(
            paddingView
        )
        self.paddingView = paddingView
        
        self.contentView.sendSubviewToBack(paddingView)
        
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
            
            if let viewModel = self.viewModel, let owner = viewModel.cellOwner {
                if case CellOwner.nib(_) = owner {} else {
                    self.setupLayout()
                }
            }
            
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
        
        self.backgroundColor = self.viewModel.contentViewColor
        self.contentView.backgroundColor = self.viewModel.contentViewColor
        self.layer.cornerRadius = self.viewModel.cornerRadius
        
        self.paddingView.backgroundColor = self.viewModel.backgroundColor
        self.paddingView.layer.cornerRadius = self.viewModel.paddingViewCornerRadius
        self.paddingView.clipsToBounds = true
        
        self.isSelected = self.viewModel.isSelected
        self.selectionStyle = self.viewModel.selectionStyle
        self.backgroundView?.backgroundColor = self.viewModel.backgroundViewColor
        
    }
    
}
