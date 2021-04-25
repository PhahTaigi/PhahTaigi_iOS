
import Foundation
import RealmSwift

public class RealmDatabaseLoader {
    static let realmDatabaseName = "PhahTaigiImeDict_2"
    
    public static func getBundledRealm() -> Realm {
        let fileUrl = Bundle.main.url(forResource: realmDatabaseName, withExtension: "realm")
        
        let config = Realm.Configuration(
            // Get the URL to the bundled file
            fileURL: fileUrl,
            // Open the file in read-only mode as application bundles are not writeable
            readOnly: true)
        
        // Open the Realm with the configuration
        let realm = try! Realm(configuration: config)
        
        print(realm.configuration.fileURL!)
        
        return realm
    }
}
