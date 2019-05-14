import UIKit
import Stevia

protocol RoutineCollnctiobViewCellDelegate: class {
    func didSelectCellViewModel(viewModel: RoutineCollectionViewCellViewModel)
}



//class NewCell: UIView, RoutineContainer {
//    
//}


class RoutineCollectionViewCell<T: RoutineCollectionViewCellViewModel>: UICollectionViewCell, RoutineContainer {
    
    var viewName: String?
    var viewModel: T!
    
    weak var paddingView: UIView!
    
    var didSetupConstraints: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
                
        self.layout(
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
                if case RoutineCellOwner.nib(_) = owner {} else {
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
        
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.viewModel.cornerRadius
        
        self.paddingView.backgroundColor = self.viewModel.backgroundColor
        self.paddingView.layer.cornerRadius = self.viewModel.paddingViewCornerRadius
        self.paddingView.clipsToBounds = true
        
        self.isSelected = self.viewModel.isSelected
        self.backgroundView?.backgroundColor = self.viewModel.backgroundViewColor
        
    }
    
}
