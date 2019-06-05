
import UIKit

class KeyView: KeyboardButton {
    
    var key: Key?
    
    static func create(frame: CGRect, key: Key) -> KeyView {
        let keyView: KeyView
        if (key.keyType == .keyboardChange) {
            keyView = KeyView(type: .custom)
        } else {
            keyView = KeyView(frame: frame)
        }
        
        keyView.setup(frame: frame, key: key)
        
        return keyView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open var isHighlighted: Bool {
        didSet {
            if (self.key!.keyType != .charactor) {
                self.backgroundColor = self.isHighlighted ? self.kbBackgroundHighlightedColor : self.kbBackgroundColor
            }
        }
    }
    
    fileprivate func setup(frame: CGRect, key: Key) {
        self.frame = frame
        self.key = key
        
        switch key.keyType {
        case .shift:
            setTitleFontSize(size: KeyConstant.keyIconTitleFontSize)
            self.setTitle(KeyConstant.shiftIconString, for: .normal)
            
            resetSpecialKeyBackgroundColor()
            
        case .backspace:
            setTitleFontSize(size: KeyConstant.keyIconTitleFontSize)
            self.setTitle(KeyConstant.backspaceIconString, for: .normal)
            
            resetSpecialKeyBackgroundColor()
            
        case .symbolPage:
            setTitleFontSize(size: KeyConstant.keyIconSymbolPageTitleFontSize)
            self.titleLabel!.adjustsFontSizeToFitWidth = true
            self.setTitle(KeyConstant.symbolPageKeyTitle, for: .normal)
            
            resetSpecialKeyBackgroundColor()
            
        case .keyboardChange:
            setImageButtonEdgeInsets()
            let image = UIImage(named: "Globe")!.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: .normal)
            
            resetSpecialKeyBackgroundColor()
            
        case .space:
            setTitleFontSize(size: KeyConstant.keySpaceTitleFontSize)
            self.setTitle(KeyConstant.spaceKeyTitle, for: .normal)
            
            resetCurrentColor(kbTitleColor: KeyConstant.keySpaceTitleColor,
                              kbBackgroundColor: KeyConstant.keySpecialBackgroundColor,
                              kbBackgroundHighlightedColor: KeyConstant.keySpecialHighlightedBackgroundColor)
            
        case .hanloSwitch:
            setTitleFontSize(size: KeyConstant.keyIconHanloSwitchTitleFontSize)
            self.setTitle(KeyConstant.hanloSwitchKeyTitleLo, for: .normal)
            
            resetSpecialKeyBackgroundColor()
            
        case .enter:
            setTitleFontSize(size: KeyConstant.keyIconTitleFontSize)
            self.setTitle(KeyConstant.enterIconString, for: .normal)
            
            resetSpecialKeyBackgroundColor()
            
        case .lomajiPage:
            setTitleFontSize(size: KeyConstant.keyIconLomajiPageTitleFontSize)
            self.titleLabel!.adjustsFontSizeToFitWidth = true
            self.setTitle(KeyConstant.lomajiPageKeyTitle, for: .normal)
            
            resetSpecialKeyBackgroundColor()
            
        case .charactor:
            self.setTitle(self.key!.halfwidthKeyCode, for: .normal)
        }
    }
    
    fileprivate func resetSpecialKeyBackgroundColor() {
        resetCurrentColor(kbTitleColor: nil,
                          kbBackgroundColor: KeyConstant.keySpecialBackgroundColor,
                          kbBackgroundHighlightedColor: KeyConstant.keySpecialHighlightedBackgroundColor)
    }
    
    func getOutputCharStringByCurrentKeyStatus() -> String? {
        if self.key!.keyType == .charactor {
            if CurrentKeyboardStatus.shiftStatus == .shifted || CurrentKeyboardStatus.shiftStatus == .locked {
                if CurrentKeyboardStatus.hanloStatus == .lomaji {
                    return self.key!.halfwidthKeyCodeShifted
                } else {
                    return self.key!.fullwidthKeyCodeShifted
                }
            } else {
                if CurrentKeyboardStatus.hanloStatus == .lomaji {
                    return self.key!.halfwidthKeyCode
                } else {
                    return self.key!.fullwidthKeyCode
                }
            }
        }
        
        return nil
    }
    
    func updateByCurrentKeyStatus() {
        // update char keys
        if self.key!.keyType == .charactor {
            if CurrentKeyboardStatus.shiftStatus == .shifted || CurrentKeyboardStatus.shiftStatus == .locked {
                if CurrentKeyboardStatus.hanloStatus == .lomaji {
                    self.setTitle(self.key!.halfwidthKeyCodeShifted, for: .normal)
                } else {
                    self.setTitle(self.key!.fullwidthKeyCodeShifted, for: .normal)
                }
            } else {
                if CurrentKeyboardStatus.hanloStatus == .lomaji {
                    self.setTitle(self.key!.halfwidthKeyCode, for: .normal)
                } else {
                    self.setTitle(self.key!.fullwidthKeyCode, for: .normal)
                }
            }
        }
        
        // update shift key
        if (self.key!.keyType == .shift) {
            switch CurrentKeyboardStatus.shiftStatus {
            case .normal:
                self.setTitle(KeyConstant.shiftIconString, for: .normal)
                
                resetCurrentColor(kbTitleColor: KeyConstant.keyTitleColor,
                                  kbBackgroundColor: KeyConstant.keySpecialBackgroundColor,
                                  kbBackgroundHighlightedColor: KeyConstant.keyShiftedBackgroundColor)
                
            case .shifted:
                self.setTitle(KeyConstant.shiftIconString, for: .normal)
                
                resetCurrentColor(kbTitleColor: KeyConstant.keyShiftedTitleColor,
                                  kbBackgroundColor: KeyConstant.keyShiftedBackgroundColor,
                                  kbBackgroundHighlightedColor: KeyConstant.keySpecialBackgroundColor)
                
            case .locked:
                self.setTitle(KeyConstant.shiftLockIconString, for: .normal)
                
                resetCurrentColor(kbTitleColor: KeyConstant.keyShiftedTitleColor,
                                  kbBackgroundColor: KeyConstant.keyShiftedBackgroundColor,
                                  kbBackgroundHighlightedColor: KeyConstant.keySpecialBackgroundColor)
            }
        }
        
        // update hanlo switch key
        if self.key!.keyType == .hanloSwitch {
            switch CurrentKeyboardStatus.hanloStatus {
            case .lomaji:
                self.setTitle(KeyConstant.hanloSwitchKeyTitleLo, for: .normal)
            case .hanji:
                self.setTitle(KeyConstant.hanloSwitchKeyTitleHan, for: .normal)
            }
        }
    }
    
    fileprivate func setImageButtonEdgeInsets() {
        let smallerEdgeLength: CGFloat = self.frame.width < self.frame.height ? self.frame.width : self.frame.height
        let imageInset: CGFloat = smallerEdgeLength * 0.25
        self.imageEdgeInsets = UIEdgeInsets(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset)
    }
    
    fileprivate func setTitleFontSize(size: CGFloat) {
        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: size)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.key!.keyType == .charactor {
            return nil
        } else {
            return super.hitTest(point, with: event)
        }
    }
}
