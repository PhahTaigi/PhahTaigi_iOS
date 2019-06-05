
import UIKit

class SelectionView: UIView {
    
    var inputDisplayView: InputDisplayView?
    var candidateWordView: CandidateWordView?
    
    var menuBarView: MenuBarView?

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = KeyboardViewConstant.keyboardViewBackgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
