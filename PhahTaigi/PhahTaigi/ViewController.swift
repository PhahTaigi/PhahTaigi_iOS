
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let versionNumberString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        self.versionLabel.text = "v\(versionNumberString)"
    }

}

