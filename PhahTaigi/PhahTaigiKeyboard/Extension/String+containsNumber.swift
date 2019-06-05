
import Foundation

extension String {
    
    func containsNumbers() -> Bool {
        // check if there's a range for a number
        let range = self.rangeOfCharacter(from: .decimalDigits)
        
        // range will be nil if no whitespace is found
        if let _ = range {
            return true
        } else {
            return false
        }
    }
}
