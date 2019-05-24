import UIKit

//FIXME: ViewModel
class RoutineHtmlTextView: RoutineTextView<RoutineTextViewModel> {
    
    private var privateHtmlText: String?
    var htmlText: String? {
        get {
            return self.privateHtmlText
        }
        set(newValue) {
            if let html = newValue {
                let htmlData = NSString(string: html).data(using: String.Encoding.unicode.rawValue)
                let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                
                let attributedStringFromHtml = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                                              options: options,
                                                                              documentAttributes: nil)
                
                self.attributedText = attributedStringFromHtml
                self.privateHtmlText = newValue
            } else {
                self.attributedText = nil
                self.privateHtmlText = nil
            }
        }
    }
    
    var fullHeight: CGFloat {
        let size = self.sizeThatFits(CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        return size.height
    }
    
    override func setupViewModel() {
        super.setupViewModel()
        
        self.isScrollEnabled = false
        self.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.isEditable = false
    }
    
}
