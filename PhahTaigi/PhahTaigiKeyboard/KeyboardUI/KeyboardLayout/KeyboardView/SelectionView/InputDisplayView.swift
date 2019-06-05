
import UIKit

class InputDisplayView: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        self.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        self.font = self.font.withSize(KeyboardViewConstant.inputDisplayLabelFontSize)
        
        self.numberOfLines = 1
        self.adjustsFontSizeToFitWidth = false
        self.lineBreakMode = .byClipping
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
