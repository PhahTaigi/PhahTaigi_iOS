
import Foundation

extension String {
    
    func contains(regex: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: regex, options: [.caseInsensitive]) else { return false }
        let matches  = regex.matches(in: self, options: [], range: NSMakeRange(0, (self as NSString).length))
        return matches.count > 0
    }
}
