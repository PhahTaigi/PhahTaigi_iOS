
import UIKit

class CustomInputView: UIInputView {
    var intrinsicHeight: CGFloat = KeyboardViewConstant.keyboardHeight {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    init() {
        super.init(frame: CGRect(), inputViewStyle: .keyboard)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: self.intrinsicHeight)
    }
}
