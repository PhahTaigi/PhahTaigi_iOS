
import Foundation

extension String {
    
    func subString(startIndex: Int, endIndex: Int) -> String {
        return self[startIndex..<endIndex]
    }
    
    func subString(easyRange: EasyRange) -> String {
        return self[easyRange.startIndex ..< easyRange.endIndex]
    }
    
    func subString(range: Range<Int>) -> String {
        return self[range]
    }
    
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
