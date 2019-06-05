
import Foundation

extension String {
    
    func lastCharString() -> String {
        return String(self.suffix(1))
    }
    
    func last2ndCharString() -> String {
        return String(self[self.count - 2 ..< count])
    }
}
