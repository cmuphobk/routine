import UIKit

class StandartPasswordTextField: UITextField {
    
    var isOk: Bool?
    
    var isMainField: Bool = true {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override var isSecureTextEntry: Bool {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override var text: String? {
        didSet {
            if self.text == nil || self.text == "" {
                self.isOk = nil
            }
            self.setNeedsLayout()
        }
    }

    weak private var eyeButton: UIButton!
    weak private var okImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isSecureTextEntry = true
        
        self.textColor = ColorProvider.default.blackColor
        self.font = FontProvider.default.textFieldButton
        self.returnKeyType = .done
        self.textAlignment = .center
        
        let eyeButton = UIButton()
        self.addSubview(eyeButton)
        self.eyeButton = eyeButton
        
        let okImageView = UIImageView()
        self.addSubview(okImageView)
        self.okImageView = okImageView
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.configureRightPanel()
        
    }
    
    private func configureRightPanel() {
        
        guard let eyeButton = self.eyeButton else { return }
        guard let okImageView = self.okImageView else { return }
        
        let eyeButtonHeight = self.frame.height
        let okButtonHeight: CGFloat = 16.0
        
        eyeButton.frame = CGRect(x: self.frame.width - eyeButtonHeight - 8.0, y: 0.0, width: eyeButtonHeight, height: eyeButtonHeight)
        eyeButton.contentMode = .scaleAspectFit
        eyeButton.setTitle(nil, for: .normal)
        eyeButton.tintColor = ColorProvider.default.lightGrayColor
        eyeButton.addTarget(self, action: #selector(clickEyeButton), for: .touchDown)
        
        okImageView.frame = CGRect(x: self.frame.width - eyeButtonHeight - 8.0, y: self.frame.height/2 - okButtonHeight/2, width: eyeButtonHeight, height: okButtonHeight)
        okImageView.contentMode = .scaleAspectFit
        
        if self.isMainField == true {
            
            eyeButton.isHidden = false
            
            if self.isSecureTextEntry == true {
                eyeButton.setImage(ImageProvider.authImages.eyeIcon, for: .normal)
            } else {
                eyeButton.setImage(ImageProvider.authImages.eyeOpenIcon, for: .normal)
            }
            
            okImageView.isHidden = true
            
        } else {
            
            eyeButton.isHidden = true
            
            guard let isOk = self.isOk else {
                okImageView.isHidden = true
                return
            }
            
            okImageView.isHidden = false
            okImageView.image = isOk ? ImageProvider.default.passOkIcon : ImageProvider.default.passNoIcon
            
        }
        
    }
    
    @objc private func clickEyeButton() {
    
        self.isSecureTextEntry = !isSecureTextEntry
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let eyeButtonHeight = self.frame.height
        let padding = UIEdgeInsets(top: 0, left: eyeButtonHeight, bottom: 0, right: eyeButtonHeight + 8.0)
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let eyeButtonHeight = self.frame.height
        let padding = UIEdgeInsets(top: 0, left: eyeButtonHeight, bottom: 0, right: eyeButtonHeight + 8.0)
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let eyeButtonHeight = self.frame.height
        let padding = UIEdgeInsets(top: 0, left: eyeButtonHeight, bottom: 0, right: eyeButtonHeight + 8.0)
        return bounds.inset(by: padding)
    }
    
}
