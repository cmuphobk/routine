import UIKit

extension UITableView {
    
    func scrollToTop() {
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
}
