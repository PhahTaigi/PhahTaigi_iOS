
import UIKit

class MenuBarView: UIView {
    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var settingButtonTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingButtonWidthConstraint: NSLayoutConstraint!
    
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
        var keyFakeGap: CGFloat
        if UIDevice.current.userInterfaceIdiom == .phone || KeyboardViewController.isRunningIphoneOnlyAppOnIpad {
            keyFakeGap = KeyConstant.keyFakeGapWidthForIphone
        } else {
            keyFakeGap = KeyConstant.keyFakeGapWidthForIpad
        }
        
        var settingButtonWidth = (self.bounds.width - (keyFakeGap * 20)) / 5
        if UIDevice.current.userInterfaceIdiom == .pad && !KeyboardViewController.isRunningIphoneOnlyAppOnIpad {
            settingButtonWidth = settingButtonWidth / 2
        }
        settingButtonWidthConstraint.constant = settingButtonWidth
        
        if UIDevice.current.userInterfaceIdiom == .phone || KeyboardViewController.isRunningIphoneOnlyAppOnIpad {
            settingButtonTrailingConstraint.constant = KeyConstant.keyFakeGapWidthForIphone
        } else {
            settingButtonTrailingConstraint.constant = KeyConstant.keyFakeGapWidthForIpad
        }
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
