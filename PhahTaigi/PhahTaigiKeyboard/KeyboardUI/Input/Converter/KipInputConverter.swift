
import Foundation

class KipInputConverter {
    
    fileprivate static let banloWordExtractPattern = "(?:(ph|p|m|b|th|tsh|ts|t|l|kh|k|ng|n|g|h|s|j)?([aiueo+]+(?:nn)?|ng|m)(?:(ng|m|n|re|r)|(p|t|h|k))?([12345789])?|(ph|p|m|b|th|tsh|ts|t|l|kh|k|ng|n|g|h|s|j)-?-?)"
    
    static func convertBanloNumberRawInputToBanloWords(input: String?) -> String {
//        print("-------------------------------------")
        
        if input == nil {
            return ""
        }
        let trimInput = input!.trimmingCharacters(in: .whitespaces)
        if trimInput.isEmpty {
            return ""
        }
        
        var banloWords = ""
        
        let results = trimInput.matches(regex: self.banloWordExtractPattern)
//        for result in results {
//            print("convertBanloNumberRawInputToBanloWords: result=\(result)")
//        }
        
        if results.count == 0 {
            return ""
        } else {
            for i in 0..<results.count {
                let foundTaigiWord = results[i]
//                print("convertBanloNumberRawInputToBanloWords: foundTaigiWord=\(foundTaigiWord)")
                let banlo = convertBanloNumberToBanlo(banloNumber: foundTaigiWord)
//                print("convertBanloNumberRawInputToBanloWords: banlo=\(banlo)")
                
                banloWords.append(banlo)
                
                if i < results.count - 1 {
                    banloWords.append("-")
                }
            }
        }
        
        return banloWords
    }
    
    fileprivate static func convertBanloNumberToBanlo(banloNumber: String) -> String {
        let fixedBanloNumber = ConverterUtils.fixLomajiNumberFormat(lomajiNumber: banloNumber);
//        print("fixedBanloNumber: \(fixedBanloNumber)")
        
        if fixedBanloNumber.count <= 1 {
            return fixedBanloNumber
        }
        
        var number = ""
        
        let lastCharString = fixedBanloNumber.lastCharString()
//        print("convertBanloNumberToBanlo(), lastCharString: \(lastCharString)")
        
        if !lastCharString.isNumber {
            return fixedBanloNumber
        } else {
            number = lastCharString
            
            let banloWithoutNumber = fixedBanloNumber.subString(startIndex: 0, endIndex: fixedBanloNumber.count - 1)
            
            let tonePosition = calculateBanloTonePosition(banloWithoutNumber: banloWithoutNumber)
            
            let banlo = generateBanloInput(banloWithoutNumber: banloWithoutNumber, number: number, tonePosition: tonePosition);
            
//            print("banloWithoutNumber=\(banloWithoutNumber), number=\(number), tonePosition=\(tonePosition), banlo=\(banlo)")
            
            return banlo
        }
    }
    
    fileprivate static func calculateBanloTonePosition(banloWithoutNumber: String) -> Int {
        let indexOfA = banloWithoutNumber.lastIndexForRegex(regex: "a")
        if indexOfA >= 0 {
            return indexOfA
        }
        
        let indexOfVowel = banloWithoutNumber.lastIndexForRegex(regex: "i|u|oo|o|e")
        if indexOfVowel >= 0 {
//            let currentCharString = banloWithoutNumber.subString(startIndex: indexOfVowel, endIndex: indexOfVowel + 1)
//            print("found tonenumber char: \(currentCharString)")
            return indexOfVowel
        }
        
        let indexOfSemiVowel = banloWithoutNumber.lastIndexForRegex(regex: "ng|n|m")
        if indexOfSemiVowel >= 0 {
//            let currentCharString = banloWithoutNumber.subString(startIndex: indexOfSemiVowel, endIndex: indexOfSemiVowel + 1)
//            print("found tonenumber char: \(currentCharString)")
            
            return indexOfSemiVowel
        }
        
        return -1
    }
    
    fileprivate static func generateBanloInput(banloWithoutNumber: String, number: String, tonePosition: Int) -> String {
        var stringBuilder = ""
        
        for i in 0..<banloWithoutNumber.count {
            let currentCharString = banloWithoutNumber.subString(startIndex: i, endIndex: i+1)
            
            if (i == tonePosition) {
                let banloNumber = currentCharString + number;
                let banlo = Kip.banloNumberToBanloUnicodeDictionary[banloNumber]
                if banlo != nil {
                    stringBuilder.append(banlo!);
                } else {
                    stringBuilder.append(currentCharString);
                }
            } else {
                stringBuilder.append(currentCharString);
            }
        }
        
        
        
        return stringBuilder
    }
}
