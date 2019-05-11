import UIKit
import Stevia

class RoutineCollectionView<T: RoutineCollectionViewModel>: UICollectionView, RoutineContainer {
    
    typealias ViewModel = T
    
    var viewName: String?
    var viewModel: T!
        
    var didSetupConstraints: Bool = false
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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
        
        self.allowsSelection = true
        
        self.contentInset = self.viewModel.contentInset
        
    }
}
