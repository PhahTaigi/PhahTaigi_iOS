
import Foundation

class ConverterUtils {
    
    static func fixBosianntiauOo(noNumberLomaji: String) -> String {
        return noNumberLomaji.replacingOccurrences(of: "OO", with: "O͘")
            .replacingOccurrences(of: "Oo", with: "O͘")
            .replacingOccurrences(of: "oo", with: "o͘")
    }
    
    static func fixLomajiNumberFormat(lomajiNumber: String) -> String {
        let foundNumberIndex = findCorrectNumberIndex(lomajiNumber: lomajiNumber);
        if foundNumberIndex == -1 {
            return lomajiNumber
        }
        
        print("foundNumberIndex: \(foundNumberIndex)")
        
        let startIndex = lomajiNumber.index(lomajiNumber.startIndex, offsetBy: 0)
        let endIndex = lomajiNumber.index(lomajiNumber.startIndex, offsetBy: foundNumberIndex)
        return String(lomajiNumber[startIndex...endIndex])
    }
    
    // ex: handle tai5566 -> tai5
    fileprivate static func findCorrectNumberIndex(lomajiNumber: String) -> Int {
        var foundNumberIndex = -1;
        
        let count = lomajiNumber.count
        let range = (0...count-1).reversed()
        for i in range {
            let possibleSianntiauText = lomajiNumber.subString(startIndex: i, endIndex: i+1)
            print("possibleSianntiauText: \(possibleSianntiauText)")
            if possibleSianntiauText.isNumber {
                foundNumberIndex = i
                print("get foundNumberIndex: \(foundNumberIndex)")
            } else {
                break
            }
        }
        
        return foundNumberIndex
    }
}
