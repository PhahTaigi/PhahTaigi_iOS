
import UIKit

class KeyPopupView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setView() {
        self.isUserInteractionEnabled = false
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: self.bounds.height * 0.75, right: 0)
        
        self.setTitleColor(KeyConstant.keyTitleColor, for: .normal)
        backgroundColor = KeyConstant.keyPopupBackgroundColor
        
        self.layer.cornerRadius = KeyConstant.keyLayerCornerRadius
        
        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: KeyConstant.keyPopupTextTitleFontSize)
        self.titleLabel!.numberOfLines = 1
        self.titleLabel!.adjustsFontSizeToFitWidth = false
        self.titleLabel!.lineBreakMode = .byClipping
        
        self.layer.masksToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func setTitle(title: String) {
        setTitle(title, for: .normal)
    }
}
