
import UIKit

class MenuBarView: UIView {
    
    @IBOutlet weak var taiEngSegmentedControl: UISegmentedControl!
    @IBOutlet weak var taiEngSegmentedControlWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var settingButtonTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingButtonWidthConstraint: NSLayoutConstraint!
    
    // callback function
    var onSelectedTaiEngSegmentedControl: ((_ selectedSegmentIndex: Int)->())?
    
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
        
        self.taiEngSegmentedControl.setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 22),
             .foregroundColor: KeyConstant.keyTitleColor],
            for: .normal)
        self.taiEngSegmentedControl.setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 22),
             .foregroundColor: KeyConstant.keyTitleColor],
            for: .selected)
        
        // handle event
        self.taiEngSegmentedControl.addTarget(self, action: #selector(taiEngSegmentedControlSelected(sender:)), for: .valueChanged)
        
        self.taiEngSegmentedControl.fixOldStyleUnder13()
    }
    
    @objc fileprivate func taiEngSegmentedControlSelected(sender: UISegmentedControl){
        self.onSelectedTaiEngSegmentedControl?(sender.selectedSegmentIndex)
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
        self.settingButtonWidthConstraint.constant = settingButtonWidth
        
        if UIDevice.current.userInterfaceIdiom == .phone || KeyboardViewController.isRunningIphoneOnlyAppOnIpad {
            settingButtonTrailingConstraint.constant = KeyConstant.keyFakeGapWidthForIphone
        } else {
            settingButtonTrailingConstraint.constant = KeyConstant.keyFakeGapWidthForIpad
        }
        
        self.taiEngSegmentedControlWidthConstraint.constant = settingButtonWidth * 2;
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
