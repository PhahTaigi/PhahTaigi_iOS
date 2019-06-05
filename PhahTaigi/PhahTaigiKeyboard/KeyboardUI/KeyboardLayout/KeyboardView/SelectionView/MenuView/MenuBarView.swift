
import UIKit

class MenuBarView: UIView {
    
    @IBOutlet weak var settingButton: UIButton!
    
    init(parentView: UIView) {
        super.init(frame: parentView.bounds)
        
        let assets = Bundle(for: type(of: self)).loadNibNamed("MenuBarView", owner: self, options: nil)
        
        if (assets?.count ?? 0) > 0 {
            if let menuNibView = assets?.first as? UIView {
                menuNibView.frame = parentView.bounds
                self.addSubview(menuNibView)
            }
        }
        
        self.settingButton.imageView?.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        let settingButtonWidth = (self.bounds.width * 0.2) + 15
        self.settingButton.frame = CGRect(x: self.bounds.width - settingButtonWidth + 10,
                                          y: self.settingButton.frame.origin.y,
                                          width: settingButtonWidth,
                                          height: self.settingButton.bounds.height)
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
