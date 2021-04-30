import Foundation
import RealmSwift

class ImeDictModel: Object {
    @objc dynamic var wordId: Int = 0
    @objc dynamic var poj: String = ""
    @objc dynamic var pojSujip: String = ""
    @objc dynamic var pojSujipBoSooji: String = ""
    @objc dynamic var pojSujipThauJibo: String = ""
    @objc dynamic var kip: String = ""
    @objc dynamic var kipSujip: String = ""
    @objc dynamic var kipSujipBoSooji: String = ""
    @objc dynamic var kipSujipThauJibo: String = ""
    @objc dynamic var hanji: String = ""
    @objc dynamic var pojPriority: Int = 0
    @objc dynamic var kipPriority: Int = 0
    @objc dynamic var srcDict: Int = 0

    override static func primaryKey() -> String? {
        return "wordId"
    }

    override static func indexedProperties() -> [String] {
        return ["pojSujip", "pojSujipBoSooji", "pojSujipThauJibo", "kipSujip", "kipSujipBoSooji", "kipSujipThauJibo", "pojPriority", "kipPriority"]
    }
    
    func detached() -> ImeDictModel {
        let detached = ImeDictModel()
        
        detached.wordId = self.wordId
        detached.poj = self.poj
        detached.pojSujip = self.pojSujip
        detached.pojSujipBoSooji = self.pojSujipBoSooji
        detached.pojSujipThauJibo = self.pojSujipThauJibo
        detached.kip = self.kip
        detached.kipSujip = self.kipSujip
        detached.kipSujipBoSooji = self.kipSujipBoSooji
        detached.kipSujipThauJibo = self.kipSujipThauJibo
        detached.hanji = self.hanji
        detached.pojPriority = self.pojPriority
        detached.kipPriority = self.kipPriority
        detached.srcDict = self.srcDict
    
        return detached
    }

}

