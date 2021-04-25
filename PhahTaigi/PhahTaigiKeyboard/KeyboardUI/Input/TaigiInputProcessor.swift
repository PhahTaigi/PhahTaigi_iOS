
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
//        NSLog("findCandidateWords: input=\(input)")
        
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
                    unicodeWordCandidate = KipInputConverter.convertBanloNumberRawInputToBanloWords(input: input)
                }
                
                // find dict candidate
                let realmDictCandidates = self.queryFromDictDatabase(input: input)
                
//                for candidate in realmDictCandidates {
//                    print("candidate.kip = \(candidate.kip)")
//                }
                
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
    
    fileprivate func queryFromDictDatabase(input: String) -> [ImeDictModel] {
        print("queryFromDictDatabase: \(input)")
        let inputFix = input.replacingOccurrences(of: "1", with: "").replacingOccurrences(of: "4", with: "")
        
        let predicate: NSPredicate?
        if inputFix.containsNumbers() {
            if CurrentSetting.isPoj() {
                predicate = NSPredicate(format: "pojSujip BEGINSWITH[c] %@", inputFix)
            } else {
                predicate = NSPredicate(format: "kipSujip BEGINSWITH[c] %@", inputFix)
            }
        } else {
            if CurrentSetting.isPoj() {
                predicate = NSPredicate(format: "pojSujipBoSooji BEGINSWITH[c] %@ OR pojSujipThauJibo BEGINSWITH[c] %@", inputFix, inputFix)
            } else {
                predicate = NSPredicate(format: "kipSujipBoSooji BEGINSWITH[c] %@ OR kipSujipThauJibo BEGINSWITH[c] %@", inputFix, inputFix)
            }
        }
        
        var sortKeyPath: String?
        if CurrentSetting.isPoj() {
            sortKeyPath = "pojPriority"
        } else {
            sortKeyPath = "kipPriority"
        }
        let realmResults = RealmDatabaseLoader.getBundledRealm().objects(ImeDictModel.self).filter(predicate!).sorted(byKeyPath: sortKeyPath!, ascending: true)
        
//        print("realmResults amount: \(realmResults.count)")
        
        var unmanagedResults = [ImeDictModel]()
        
        var maxCount: Int
        if (realmResults.count < realmDatabaseResultLimit) {
            maxCount = realmResults.count
        } else {
            maxCount = realmDatabaseResultLimit
        }
        
        for index in 0..<maxCount {
            unmanagedResults.append(realmResults[index] .detached())
        }
        
        return checkShiftedInput(inputFix, unmanagedResults)
    }
    
    fileprivate func checkShiftedInput(_ input: String, _ results: [ImeDictModel]) -> [ImeDictModel] {
        // handle caps with shiftStatus
        let firstCharString = input.prefix(1)
        if firstCharString.uppercased() != firstCharString {
            return results
        }
        
        for result: ImeDictModel in results {
            if input.uppercased() == input {
                if CurrentSetting.isPoj() {
                    result.poj = result.poj.uppercased()
                } else {
                    result.kip = result.kip.uppercased()
                }
                continue
            }
            if firstCharString.uppercased() == firstCharString {
                if CurrentSetting.isPoj() {
                    result.poj = result.poj.prefix(1).uppercased() + result.poj.suffix(result.poj.count - 1)
                } else {
                    result.kip = result.kip.prefix(1).uppercased() + result.kip.suffix(result.kip.count - 1)
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
    
    fileprivate func setCandidates(input: String, lomajiCandidates: [String], hanloCandidates: [ImeDictModel]) {
        // check async callback
        if input != self.currentInputString {
            return
        }
        
        self.keyboardView.selectionView!.candidateWordView!.setCandidates(lomajiCandidates: lomajiCandidates, hanloCandidates: hanloCandidates)
    }

}

