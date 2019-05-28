import UIKit

// FIXME: - ViewModel
class RoutineModalView: RoutineView<RoutineViewModel>, UIGestureRecognizerDelegate {
    // MARK: - Properties
    weak var delegate: RoutineModalViewDelegate?

    lazy var modalContainer: UIView = {
        let modalContainer = UIView()
        modalContainer.backgroundColor = UIColor.white

        if !modalContainer.isDescendant(of: self) {
            self.addSubview(modalContainer)
        }
        return modalContainer
    }()

    var blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)

    lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: self.blurEffect)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.alpha = 1.0
        blurView.backgroundColor = UIColor.clear

        if !blurView.isDescendant(of: self) {
            self.addSubview(blurView)
        }
        return blurView
    }()

    lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.blurView.effect = nil
        }
    }()

    var blurRadius: CGFloat = 0.8

    lazy var gestureRecognizer: UIGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
        gestureRecognizer.delegate = self

        if self.gestureRecognizers?.contains(gestureRecognizer) != true {
            self.addGestureRecognizer(gestureRecognizer)
        }

        return gestureRecognizer
    }()

    // MARK: - LifeCycle

    override func layoutSubviews() {
        super.layoutSubviews()

        self.blurView.frame = self.bounds
        self.blurView.effect = self.blurEffect

        self.animator.fractionComplete = self.blurRadius

        let rectModalContainer = CGRect(x: self.frame.width * 0.1,
                                        y: self.frame.height * 0.2,
                                        width: self.frame.width - (self.frame.width * 0.2),
                                        height: self.frame.height - (self.frame.height * 0.4))
        let centerModalContainer = CGPoint(x: self.frame.width/2, y: self.frame.height/2)

        self.modalContainer.center = centerModalContainer
        self.modalContainer.frame = rectModalContainer

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

        self.animator.startAnimation()

    }

    deinit {
        self.animator.stopAnimation(true)
        self.animator.finishAnimation(at: .start)

        print("Deinit modal")
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        let contains = self.gestureRecognizers?.contains(self.gestureRecognizer)
        if contains == true {
            self.removeGestureRecognizer(self.gestureRecognizer)
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        let contains = self.gestureRecognizers?.contains(self.gestureRecognizer)
        if contains != true {
            self.addGestureRecognizer(self.gestureRecognizer)
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.blurView {
            self.delegate?.didTriggerCloseModalAction(modal: self)
        }
        return true
    }
}
