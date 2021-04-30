
import UIKit

class CustomFontLabel: UILabel {
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        
        // you can change 'addedHeight' into any value you want.
        let addedHeight = font.pointSize * 0.3
        
        return CGSize(width: size.width, height: size.height + addedHeight)
    }
}
