import UIKit

extension Array where Element: AnyObject {
    
    func indexOf(_ reference: AnyObject) -> Int? {
        
        for (index, element) in self.enumerated() where reference === element {
            return index
        }
        
        return nil
    }
    
}
