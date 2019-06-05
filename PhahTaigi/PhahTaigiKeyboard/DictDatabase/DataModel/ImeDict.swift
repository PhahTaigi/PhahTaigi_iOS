import Foundation
import RealmSwift

class ImeDict: Object {
    
    @objc dynamic var wordId = 0
    @objc dynamic var mainCode = 0
    @objc dynamic var wordPropertyCode = 0
    @objc dynamic var tailo = ""
    @objc dynamic var tailoInputWithNumberTone = ""
    @objc dynamic var tailoInputWithoutTone = ""
    @objc dynamic var tailoShortInput = ""
    @objc dynamic var poj = ""
    @objc dynamic var pojInputWithNumberTone = ""
    @objc dynamic var pojInputWithoutTone = ""
    @objc dynamic var pojShortInput = ""
    @objc dynamic var priority = 0
    @objc dynamic var wordLength = 0
    @objc dynamic var lomajiCharLength = 0
    @objc dynamic var hanji = ""
    
    override static func primaryKey() -> String? {
        return "wordId"
    }
    
    override static func indexedProperties() -> [String] {
        return [
            "tailo",
            "tailoInputWithNumberTone",
            "tailoInputWithoutTone",
            "tailoShortInput",
            "poj",
            "pojInputWithNumberTone",
            "pojInputWithoutTone",
            "pojShortInput",
            "hanji",
        ]
    }
    
    func detached() -> ImeDict {
        let detached = ImeDict()
        
        detached.wordId = self.wordId
        detached.mainCode = self.mainCode
        detached.wordPropertyCode = self.wordPropertyCode
        detached.tailo = self.tailo
        detached.tailoInputWithNumberTone = self.tailoInputWithNumberTone
        detached.tailoInputWithoutTone = self.tailoInputWithoutTone
        detached.tailoShortInput = self.tailoShortInput
        detached.poj = self.poj
        detached.pojInputWithNumberTone = self.pojInputWithNumberTone
        detached.pojInputWithoutTone = self.pojInputWithoutTone
        detached.pojShortInput = self.pojShortInput
        detached.priority = self.priority
        detached.wordLength = self.wordLength
        detached.lomajiCharLength = self.lomajiCharLength
        detached.hanji = self.hanji
    
        return detached
    }
}
