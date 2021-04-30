import UIKit

class KeyboardViewLayout {
    
    static func build() -> KeyboardView {
        let keyboardView = KeyboardView(frame: CGRect(x: 0, y: 0, width: KeyboardViewController.keyboardWidth, height: KeyboardViewController.keyboardHeight))
        
        print("KeyboardViewLayout:keyboardView w=\(keyboardView.frame.size.width), h=\(keyboardView.frame.size.height)")
        
        let selectionViewHeight = keyboardView.frame.size.height / 100 * KeyboardViewConstant.selectionViewHeightPercentage
        let typingViewHeight = keyboardView.frame.size.height / 100 * KeyboardViewConstant.typingViewHeightPercentage
        
        keyboardView.selectionView = SelectionView(frame: CGRect(x:0,
                                                                 y:0,
                                                                 width:keyboardView.frame.size.width,
                                                                 height: selectionViewHeight))
        keyboardView.typingView = TypingView(frame: CGRect(x:0,
                                                           y:selectionViewHeight,
                                                           width:keyboardView.frame.size.width,
                                                           height: typingViewHeight))
        
        keyboardView.addSubview(keyboardView.selectionView!)
        keyboardView.addSubview(keyboardView.typingView!)
        
        SelectionViewLayout.build(selectionView: keyboardView.selectionView!)
        TypingViewLayout.build(typingView: keyboardView.typingView!)
        
        return keyboardView
    }
    
    static func resetViewLayoutForSizeChange(keyboardView: KeyboardView) {
        keyboardView.frame = CGRect(x: 0, y: 0, width: KeyboardViewController.keyboardWidth, height: KeyboardViewController.keyboardHeight)
        
        let selectionViewHeight = keyboardView.frame.size.height / 100 * KeyboardViewConstant.selectionViewHeightPercentage
        let typingViewHeight = keyboardView.frame.size.height / 100 * KeyboardViewConstant.typingViewHeightPercentage
        
        keyboardView.selectionView!.frame = CGRect(x:0,
                                                   y:0,
                                                   width:keyboardView.frame.size.width,
                                                   height: selectionViewHeight)
        keyboardView.typingView!.frame = CGRect(x:0,
                                                y:selectionViewHeight,
                                                width:keyboardView.frame.size.width,
                                                height: typingViewHeight)
        
        keyboardView.setNeedsDisplay()
        
        SelectionViewLayout.resetViewLayoutForSizeChange(selectionView: keyboardView.selectionView!)
        TypingViewLayout.resetViewLayoutForSizeChange(typingView: keyboardView.typingView!)
    }
}
