import Foundation

extension Double {
    
    func makeDoseString() -> String {
    
        let splitArray = String(self).split(separator: ".")
        return splitArray[1] == "0" ? String(splitArray[0]) : String(self)
        
    }
    
}
