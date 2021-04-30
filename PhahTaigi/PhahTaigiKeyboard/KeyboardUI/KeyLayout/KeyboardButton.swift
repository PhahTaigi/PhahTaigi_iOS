import UIKit

class KeyboardButton: UIButton {
    
    var kbTitleColor: UIColor = KeyConstant.keyTitleColor
    var kbBackgroundColor: UIColor = KeyConstant.keyBackgroundColor
    var kbBackgroundHighlightedColor: UIColor  = KeyConstant.keyHighlightedBackgroundColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setView() {
        resetCurrentColor()
        
        self.layer.cornerRadius = KeyConstant.keyLayerCornerRadius
        
        // fake key gap using the same color as keyboard background
        if UIDevice.current.userInterfaceIdiom == .phone || KeyboardViewController.isRunningIphoneOnlyAppOnIpad {
            self.layer.borderWidth = KeyConstant.keyFakeGapWidthForIphone
        } else {
            self.layer.borderWidth = KeyConstant.keyFakeGapWidthForIpad
        }
        self.layer.borderColor = KeyboardViewConstant.keyboardViewBackgroundColor.cgColor

        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: KeyConstant.keyTextTitleFontSize)
        self.titleLabel!.numberOfLines = 1
        self.titleLabel!.adjustsFontSizeToFitWidth = false
        self.titleLabel!.lineBreakMode = .byClipping
        
        self.imageView?.contentMode = .scaleAspectFit
        self.imageView?.tintColor = KeyConstant.keyTitleColor
        
        self.layer.masksToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func resetCurrentColor(kbTitleColor: UIColor?, kbBackgroundColor: UIColor?, kbBackgroundHighlightedColor: UIColor?) {
        if (kbTitleColor != nil) {
            self.kbTitleColor = kbTitleColor!
        }
        if (kbBackgroundColor != nil) {
            self.kbBackgroundColor = kbBackgroundColor!
        }
        if (kbBackgroundHighlightedColor != nil) {
            self.kbBackgroundHighlightedColor = kbBackgroundHighlightedColor!
        }
        
        resetCurrentColor()
    }
    
    func resetCurrentColor() {
        self.setTitleColor(self.kbTitleColor, for: .normal)
        self.backgroundColor = self.kbBackgroundColor
    }

}
