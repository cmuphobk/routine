import UIKit
import Stevia

class RoutineImageView<T: RoutineImageViewModel>: UIImageView, RoutineContainer {

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

        self.image = self.viewModel.image
        self.contentMode = self.viewModel.contentMode

    }

}
