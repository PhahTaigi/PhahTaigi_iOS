
import Foundation

extension String {
    
    func lastIndexForRegex(regex: String) -> Int {
        guard let regex = try? NSRegularExpression(pattern: regex, options: [.caseInsensitive]) else { return -1 }
        let matches  = regex.matches(in: self, options: [], range: NSMakeRange(0, (self as NSString).length))
        
        var lastIndex = -1
        for match in matches {
            let range = Range(match.range, in: self)
            let index = range?.lowerBound.encodedOffset ?? -1
//            print("lowerBound: \(range?.lowerBound.encodedOffset)")
//            print("upperBound: \(range?.upperBound.encodedOffset)")
//            print("index: \(index)")
            if index > lastIndex {
                lastIndex = index
            }
        }
        
        return lastIndex
    }
    
    func lastRangeForRegex(regex: String) -> EasyRange? {
        guard let regex = try? NSRegularExpression(pattern: regex, options: [.caseInsensitive]) else { return nil }
        let matches  = regex.matches(in: self, options: [], range: NSMakeRange(0, (self as NSString).length))
        
        var lastLowerBound = -1
        var lastUpperBound = -1
        for match in matches {
            let range = Range(match.range, in: self)
            let lowerBound = range?.lowerBound.encodedOffset ?? -1
            let upperBound = range?.upperBound.encodedOffset ?? -1
            print("lowerBound: \(String(describing: range?.lowerBound.encodedOffset))")
            print("upperBound: \(String(describing: range?.upperBound.encodedOffset))")
            if lowerBound > lastLowerBound {
                lastLowerBound = lowerBound
                lastUpperBound = upperBound
            }
        }
        
        if lastLowerBound == -1 {
            return nil
        } else {
            return EasyRange(startIndex: lastLowerBound, endIndex: lastUpperBound)
        }
    }
}


class EasyRange {
    var startIndex: Int
    var endIndex: Int
    
    init(startIndex: Int, endIndex: Int) {
        self.startIndex = startIndex
        self.endIndex = endIndex
    }
    
    func getRange() -> Range<Int> {
        return self.startIndex ..< self.endIndex
    }
}
