
import Foundation
import RealmSwift
import RxCocoa
import RxSwift

class TaigiInputProcessor {
    fileprivate let realmDatabaseResultLimit = 100
    
    fileprivate var keyboardView: KeyboardView
    
    fileprivate var currentInputString: String = ""
    
//        fileprivate var searchPublishSubject: PublishSubject = PublishSubject<String>()
//        fileprivate let disposeBag = DisposeBag() // Bag of disposables to release them when view is being deallocated
    
    init(keyboardView: KeyboardView) {
        self.keyboardView = keyboardView
    }
    
    func findCandidateWordsAsync(input: String) {
        print("findCandidateWords: input=\(input)")
        
        self.currentInputString = input
        
        let debouncedFunction = debounce(interval: 50, queue: DispatchQueue.main, action: {
            if input.isEmpty {
                DispatchQueue.main.async {
                    self.clearCandidates()
                }
            } else {
                // find unicode candidate
                let unicodeWordCandidate: String
                if CurrentSetting.isPoj() {
                    unicodeWordCandidate = PojInputConverter.convertPojNumberRawInputToPojWords(input: input)
                } else {
                    unicodeWordCandidate = BanloInputConverter.convertBanloNumberRawInputToBanloWords(input: input)
                }
                
                // find dict candidate
                let realmDictCandidates = self.queryFromDictDatabase(input: input)
                
                DispatchQueue.main.async {
                    self.setCandidates(input: input, lomajiCandidates: [unicodeWordCandidate], hanloCandidates: realmDictCandidates)
                }
            }
        })
        
        DispatchQueue(label: "background").async {
            autoreleasepool {
                debouncedFunction(())
            }
        }
    }
    
//    func findCandidateWordsSync(input: String) {
//        print("findCandidateWords: input=\(input)")
//
//        if input.isEmpty {
//            clearCandidates()
//            return
//        }
//
//        let unicodeWordCandidate: String
//        if CurrentSetting.isPoj() {
//            unicodeWordCandidate = PojInputConverter.convertPojNumberRawInputToPojWords(input: input)
//        } else {
//            unicodeWordCandidate = BanloInputConverter.convertBanloNumberRawInputToBanloWords(input: input)
//        }
//
//        let realmDictCandidates = queryFromDictDatabase(input: input)
//
//        self.setCandidates(lomajiCandidates: [unicodeWordCandidate], hanloCandidates: realmDictCandidates)
//    }
    
    fileprivate func queryFromDictDatabase(input: String) -> [ImeDict] {
        let inputFix = input.replacingOccurrences(of: "1", with: "").replacingOccurrences(of: "4", with: "")
        
        let predicate: NSPredicate?
        if inputFix.containsNumbers() {
            if CurrentSetting.isPoj() {
                predicate = NSPredicate(format: "pojInputWithNumberTone BEGINSWITH[c] %@", inputFix)
            } else {
                predicate = NSPredicate(format: "tailoInputWithNumberTone BEGINSWITH[c] %@", inputFix)
            }
        } else {
            if CurrentSetting.isPoj() {
                predicate = NSPredicate(format: "pojInputWithoutTone BEGINSWITH[c] %@ OR pojShortInput BEGINSWITH[c] %@", inputFix, inputFix)
            } else {
                predicate = NSPredicate(format: "tailoInputWithoutTone BEGINSWITH[c] %@ OR tailoShortInput BEGINSWITH[c] %@", inputFix, inputFix)
            }
        }
        
        let realmResults = RealmDatabaseLoader.getBundledRealm().objects(ImeDict.self).filter(predicate!).sorted(byKeyPath: "lomajiCharLength", ascending: true)
        
        var unmanagedResults = [ImeDict]()
        for result in realmResults {
            unmanagedResults.append(result.detached())
        }
        
        let limitedSizeResults = Array(unmanagedResults.prefix(realmDatabaseResultLimit))
        
        return checkShiftedInput(inputFix, limitedSizeResults)
    }
    
    fileprivate func checkShiftedInput(_ input: String, _ results: [ImeDict]) -> [ImeDict] {
        // handle caps with shiftStatus
        let firstCharString = input.prefix(1)
        if firstCharString.uppercased() != firstCharString {
            return results
        }
        
        for result: ImeDict in results {
            if input.uppercased() == input {
                if CurrentSetting.isPoj() {
                    result.poj = result.poj.uppercased()
                } else {
                    result.tailo = result.tailo.uppercased()
                }
                continue
            }
            if firstCharString.uppercased() == firstCharString {
                if CurrentSetting.isPoj() {
                    result.poj = result.poj.prefix(1).uppercased() + result.poj.suffix(result.poj.count - 1)
                } else {
                    result.tailo = result.tailo.prefix(1).uppercased() + result.tailo.suffix(result.poj.count - 1)
                }
            }
        }
        
        return results
    }
    
    fileprivate func clearCandidates() {
        self.keyboardView.selectionView!.candidateWordView!.clearCandidates()
    }
    
    func getDefaultCandidate() -> String? {
        return self.keyboardView.selectionView!.candidateWordView!.getDefaultCandidate()
    }
    
    fileprivate func setCandidates(input: String, lomajiCandidates: [String], hanloCandidates: [ImeDict]) {
        // check async callback
        if input != self.currentInputString {
            return
        }
        
        self.keyboardView.selectionView!.candidateWordView!.setCandidates(lomajiCandidates: lomajiCandidates, hanloCandidates: hanloCandidates)
    }

}

