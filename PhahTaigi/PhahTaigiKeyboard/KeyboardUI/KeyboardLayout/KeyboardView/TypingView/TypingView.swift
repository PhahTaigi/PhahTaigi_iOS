
import UIKit

class TypingView: UIView {
    
    var pages = [PageView]()
    var currentPageIndex: PageIndex = .taigi
    
    var keyPopupController: KeyPopupController?
    
    // callback function
    var onKeyUpCharactor: ((_ charText: String)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = KeyboardViewConstant.keyboardViewBackgroundColor
        
        self.keyPopupController = KeyPopupController.init(rootView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectPage(selectedPageIndex: PageIndex) {
        self.currentPageIndex = selectedPageIndex
        
        let count = pages.count
        for i in 0..<count {
            let page = pages[i]
            
            if selectedPageIndex.rawValue == i {
                page.isHidden = false
            } else {
                page.isHidden = true
            }
        }
    }
    
    func didChangedKeyboardStatus() {
        for pageView: PageView in self.pages {
            for rowView: RowView in pageView.rowViews {
                for keyView: KeyView in rowView.keyViews {
                    keyView.updateByCurrentKeyStatus()
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouch(touch: touches.first!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouch(touch: touches.first!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouchEnd(touch: touches.first!)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouchCancel()
    }
    
    private func handleTouch(touch: UITouch) {
        let point: CGPoint = touch.location(in: self)
        
        var foundKeyForPopup = false
        let pageView = pages[currentPageIndex.rawValue]
            for rowView: RowView in pageView.rowViews {
                for keyView: KeyView in rowView.keyViews {
                    if keyView.key!.keyType == .charactor {
                        let keyViewRectInTypingView = keyView.convert(keyView.bounds, to: self)
                        if keyViewRectInTypingView.contains(point) {
                            self.keyPopupController!.showPopup(forKeyView: keyView)
                            foundKeyForPopup = true
                            return
                        }
                    }
                }
            }
        
        if !foundKeyForPopup {
            self.keyPopupController!.hidePopup()
        }
    }
    
    private func handleTouchEnd(touch: UITouch) {
        self.keyPopupController!.hidePopup()
        
        let point: CGPoint = touch.location(in: self)
        
        let pageView = pages[currentPageIndex.rawValue]
        for rowView: RowView in pageView.rowViews {
            for keyView: KeyView in rowView.keyViews {
                if keyView.key!.keyType == .charactor {
                    let keyViewRectInTypingView = keyView.convert(keyView.bounds, to: self)
                    if keyViewRectInTypingView.contains(point) {
//                        print("key up: \(keyView.key!.keyCode)")
                        let outputCharString = keyView.getOutputCharStringByCurrentKeyStatus()
                            self.onKeyUpCharactor?(outputCharString!)
                        return
                    }
                }
            }
        }
    }
    
    private func handleTouchCancel() {
        self.keyPopupController!.hidePopup()
    }
}
