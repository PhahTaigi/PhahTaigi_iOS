
import Foundation

class PojInputConverter {
    
    fileprivate static let pojWordExtractPattern = "(?:(ph|p|m|b|th|t|l|kh|k|ng|n|g|h|chh|ch|s|j)?([aiueo+]+(?:nn)?|ng|m)(?:(ng|m|n|re|r)|(p|t|h|k))?([12345789])?|(ph|p|m|b|th|t|l|kh|k|ng|n|g|h|chh|ch|s|j)-?-?)"
    
    static func convertPojNumberRawInputToPojWords(input: String?) -> String {
        if input == nil {
            return ""
        }
        let trimInput = input!.trimmingCharacters(in: .whitespaces)
        if trimInput.isEmpty {
            return ""
        }
        
        var pojWords = ""
        
        let results = trimInput.matches(regex: self.pojWordExtractPattern)
//        for result in results {
//            print("convertPojNumberRawInputToPojWords: result=\(result)")
//        }
        
        if results.count == 0 {
            return ""
        } else {
            for i in 0..<results.count {
                let foundTaigiWord = results[i]
//                print("convertPojNumberRawInputToPojWords: foundTaigiWord=\(foundTaigiWord)")
                let pojNumber = convertPojRawInputToPojNumber(foundTaigiWord: foundTaigiWord);
//                print("convertPojNumberRawInputToPojWords: pojNumber=\(pojNumber)")
                let poj = convertPojNumberToPoj(pojNumber: pojNumber)
//                print("convertPojNumberRawInputToPojWords: poj=\(poj)")
                
                pojWords.append(poj)
                
                if i < results.count - 1 {
                    pojWords.append("-")
                }
            }
        }
        
        return pojWords
    }
    
    fileprivate static func convertPojRawInputToPojNumber(foundTaigiWord: String) -> String {
        var pojNumber = foundTaigiWord.replacingOccurrences(of: "Oo", with: "OO")
        
        if pojNumber.range(of: "nn")?.lowerBound.encodedOffset ?? 0 > 0 {
            pojNumber = pojNumber.replacingOccurrences(of: "nn", with: "ⁿ")
        } else if pojNumber.range(of: "NN")?.lowerBound.encodedOffset ?? 0 > 0 {
            pojNumber = pojNumber.replacingOccurrences(of: "NN", with: "ⁿ")
        }
        
        return pojNumber;
    }
    
    fileprivate static func convertPojNumberToPoj(pojNumber: String) -> String {
        let fixedPojNumber = ConverterUtils.fixLomajiNumberFormat(lomajiNumber: pojNumber);
//        print("fixedPojNumber: \(fixedPojNumber)")
        
        if fixedPojNumber.count <= 1 {
            return fixedPojNumber
        }
        
        var number = ""
        
        let lastCharString = fixedPojNumber.lastCharString()
//        print("convertPojNumberToPoj(), lastCharString: \(lastCharString)")
        
        if !lastCharString.isNumber {
            return ConverterUtils.fixBosianntiauOo(noNumberLomaji: fixedPojNumber)
        } else {
            number = lastCharString
            
            let pojWithoutNumber = fixedPojNumber.subString(startIndex: 0, endIndex: fixedPojNumber.count - 1)
            
            let toneVowelRange = calculateRangeOfPojToneVowel(pojWithoutNumber: pojWithoutNumber)
            
            let poj = generatePojInput(pojWithoutNumber: pojWithoutNumber, number: number, toneVowelRange: toneVowelRange);
            
//            print("pojWithoutNumber=\(pojWithoutNumber), number=\(number), toneVowelRange=\(String(describing: toneVowelRange?.startIndex))..<\(String(describing: toneVowelRange?.endIndex)), poj=\(poj)")
            
            return poj
        }
    }
    
    fileprivate static func calculateRangeOfPojToneVowel(pojWithoutNumber: String) -> EasyRange? {
        let pojWithoutNumberLowercased = pojWithoutNumber.lowercased()
        let count = pojWithoutNumberLowercased.count
    
//        print("calculateTonePosition: pojWithoutNumberLowercased = \(pojWithoutNumberLowercased), count = \(count)")
    
        let lastRangeOfVowel: EasyRange? = pojWithoutNumberLowercased.lastRangeForRegex(regex: "a|i|u|e|oo|o")
//        print("lastRangeOfVowel: \(String(describing: lastRangeOfVowel))")
        if lastRangeOfVowel == nil {
//            let testWithoutNN = pojWithoutNumberLowercased.replacingOccurrences(of: "nn", with: "__")
            let lastRangeOfHalfVowel = pojWithoutNumberLowercased.lastRangeForRegex(regex: "m|ng|n")
            return lastRangeOfHalfVowel
        } else {
            if count == 1 || lastRangeOfVowel!.startIndex == 0 {
                return lastRangeOfVowel
            } else {
                let previousCharString = pojWithoutNumberLowercased.subString(startIndex: lastRangeOfVowel!.startIndex-1, endIndex: lastRangeOfVowel!.startIndex)
                if previousCharString.contains(regex: "a|i|u|e|o") {
                    // vowel count >= 2
                    let lastCharString = self.findLastJibo(pojBoSianntiau: pojWithoutNumberLowercased)
                    let last2ndCharString = self.findLast2ndJibo(pojBoSianntiau: pojWithoutNumberLowercased)
                    if lastCharString.contains(regex: "p|t|k|h") {
                        // Hok Boim Jipsiann
                        if last2ndCharString.contains(regex: "i|u") {
                            if pojWithoutNumberLowercased.contains(regex: "iuh") {
                                return self.findLast2ndJiboEasyRange(pojBoSianntiau: pojWithoutNumberLowercased)
                            } else {
                                return self.findLast3rdJiboEasyRange(pojBoSianntiau: pojWithoutNumberLowercased)
                            }
                        } else {
                            return self.findLast2ndJiboEasyRange(pojBoSianntiau: pojWithoutNumberLowercased)
                        }
                    } else {
                        // Hok Boim
                        if last2ndCharString == "i" {
                            return self.findLastJiboEasyRange(pojBoSianntiau: pojWithoutNumberLowercased)
                        } else {
                            return self.findLast2ndJiboEasyRange(pojBoSianntiau: pojWithoutNumberLowercased)
                        }
                    }
                } else {
                    // vowel count == 1
                    return lastRangeOfVowel
                }
            }
        }
    }
    
    fileprivate static func findLastJibo(pojBoSianntiau: String) -> String {
        let easyRange = findLastJiboEasyRange(pojBoSianntiau: pojBoSianntiau)
        return pojBoSianntiau[easyRange.startIndex ..< easyRange.endIndex]
    }
    
    fileprivate static func findLast2ndJibo(pojBoSianntiau: String) -> String {
        let easyRange = findLast2ndJiboEasyRange(pojBoSianntiau: pojBoSianntiau)
        return pojBoSianntiau[easyRange.startIndex ..< easyRange.endIndex]
    }
    
    fileprivate static func findLastJiboEasyRange(pojBoSianntiau: String) -> EasyRange {
        return self.findJiboPositionFromLastCharExludingPhinnim(pojBoSianntiau: pojBoSianntiau, findWhichCharFromRight: 1)
    }
    
    fileprivate static func findLast2ndJiboEasyRange(pojBoSianntiau: String) -> EasyRange {
        return self.findJiboPositionFromLastCharExludingPhinnim(pojBoSianntiau: pojBoSianntiau, findWhichCharFromRight: 2)
    }
    
    fileprivate static func findLast3rdJiboEasyRange(pojBoSianntiau: String) -> EasyRange {
        return self.findJiboPositionFromLastCharExludingPhinnim(pojBoSianntiau: pojBoSianntiau, findWhichCharFromRight: 3)
    }
    
    fileprivate static func findJiboPositionFromLastCharExludingPhinnim(pojBoSianntiau: String, findWhichCharFromRight: Int) -> EasyRange {
        var pos: Int = pojBoSianntiau.count - 1
        var foundJiboCount = 0
        
        var hasFoundPojOo = false
        while (pos >= 0) {
            let currentCharString = pojBoSianntiau[pos ..< pos + 1]
            var isFoundPojOo = false
            var isFoundPojNg = false
            
            if (currentCharString == "ⁿ") {
                // skip
            } else if (currentCharString == "o" && pos - 1 >= 0) {
                let previousCharString = pojBoSianntiau[pos - 1 ..< pos]
                if (previousCharString == "o") {
                    // found "oo"
                    isFoundPojOo = true
                    hasFoundPojOo = true
                } else {
                    // found "o"
                }
                foundJiboCount = foundJiboCount + 1
            } else if (currentCharString == "g" && pos - 1 >= 0) {
                let previousCharString = pojBoSianntiau[pos - 1 ..< pos]
                if (previousCharString == "n") {
                    // found "ng"
                    isFoundPojNg = true
                } else {
                    // found "g"
                }
                foundJiboCount = foundJiboCount + 1
            } else {
                foundJiboCount = foundJiboCount + 1
            }
            
            if (foundJiboCount == findWhichCharFromRight) {
                break
            }
            
            if (isFoundPojOo || isFoundPojNg) {
                pos = pos - 2
            } else {
                pos = pos - 1
            }
            
            if (pos < 0) {
                break
            }
        }
        
        if hasFoundPojOo {
            return EasyRange(startIndex: pos, endIndex: pos + 2)
        } else {
            return EasyRange(startIndex: pos, endIndex: pos + 1)
        }
    }
    
    fileprivate static func generatePojInput(pojWithoutNumber: String, number: String, toneVowelRange: EasyRange?) -> String {
        if toneVowelRange == nil {
            return pojWithoutNumber
        }
        
        var pojInputStringBuilder = ""
        
        if toneVowelRange!.startIndex != 0 {
            pojInputStringBuilder.append(contentsOf: pojWithoutNumber[0 ..< toneVowelRange!.startIndex])
        }
        
        let currentToneVowelString = pojWithoutNumber.subString(startIndex: toneVowelRange!.startIndex, endIndex: toneVowelRange!.endIndex)
        let currentToneVowelStringWithNumber = currentToneVowelString + number
        
        let poj = Poj.pojNumberToPojUnicodeDictionary[currentToneVowelStringWithNumber]
        if poj != nil {
            pojInputStringBuilder.append(poj!);
        }
        
        if toneVowelRange!.endIndex != pojWithoutNumber.count {
            pojInputStringBuilder.append(contentsOf: pojWithoutNumber[toneVowelRange!.endIndex ..< pojWithoutNumber.count])
        }
        
        return pojInputStringBuilder
    }
    
}
