import Foundation

extension UInt8 {
    
    func binary() -> String {
        var result = ""
        for index in 0..<8 {
            let mask = 1 << index
            let set = Int(self) & mask != 0
            result = (set ? "1" : "0") + result
        }
        return result
    }
    
}

extension Int8 {
    
    func binary() -> String {
        var result = ""
        for index in 0..<8 {
            let mask = 1 << index
            let set = Int(self) & mask != 0
            result = (set ? "1" : "0") + result
        }
        return result
    }
    
}
