import UIKit

extension Collection where Element: AnyObject {
    
    func index(ref reference: AnyObject) -> Int? {
        
        for (index, element) in self.enumerated() where reference === element {
            return index
        }
        
        return nil
    }
    
}
