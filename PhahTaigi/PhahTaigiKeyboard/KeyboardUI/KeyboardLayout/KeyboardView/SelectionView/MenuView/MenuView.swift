
import UIKit

class MenuBarView: UIView {
    
    @IBOutlet weak var settingButton: UIButton!
    
    init(parentView: UIView) {
        super.init(frame: parentView.bounds)
        
        let assets = Bundle(for: type(of: self)).loadNibNamed("MenuView", owner: self, options: nil)
        
        if (assets?.count ?? 0) > 0 {
            if let menuNibView = assets?.first as? UIView {
                menuNibView.frame = parentView.bounds
                parentView.addSubview(menuNibView)
            }
        }
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
