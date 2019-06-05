import UIKit

class KeyboardView: UIView {
    var selectionView: SelectionView?
    var typingView: TypingView?
    
    var settingView: SettingView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        CurrentKeyboardStatus.didChangedShiftStatus = {
            self.typingView!.didChangedKeyboardStatus()
        }
        
        CurrentKeyboardStatus.didChangedHanloStatus = {
            self.selectionView!.candidateWordView!.reloadByHanloStatus()
            self.typingView!.didChangedKeyboardStatus()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
