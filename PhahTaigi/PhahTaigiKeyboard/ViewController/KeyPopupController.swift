
import UIKit

class KeyPopupController {
    
    fileprivate let rootView: UIView
    
    fileprivate var keyPopupView: KeyPopupView?
    
    init(rootView: UIView) {
        self.rootView = rootView
        
        self.keyPopupView = KeyPopupView(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
        self.keyPopupView!.isHidden = true
        
        self.rootView.addSubview(self.keyPopupView!)
        
        self.keyPopupView!.layer.zPosition = 1000
    }
    
    func showPopup(forKeyView: KeyView) {
        if CurrentKeyboardStatus.shiftStatus == .normal {
            self.keyPopupView!.setTitle(title: forKeyView.key!.halfwidthKeyCode)
        } else {
            self.keyPopupView!.setTitle(title: forKeyView.key!.halfwidthKeyCodeShifted)
        }
        
        let keyViewRectInRootView = forKeyView.convert(forKeyView.bounds, to: self.rootView)
        
        let w: CGFloat = keyViewRectInRootView.width
        let h: CGFloat = keyViewRectInRootView.height * 2.1
        let x: CGFloat = keyViewRectInRootView.origin.x
        let y: CGFloat = keyViewRectInRootView.origin.y - keyViewRectInRootView.height * 1.1
        let popupViewFrame = CGRect(x: x, y: y, width: w, height: h)
        
        self.keyPopupView!.frame = popupViewFrame
        
        self.keyPopupView!.isHidden = false
    }
    
    func hidePopup() {
        self.keyPopupView!.isHidden = true
    }
}
