
import Foundation
import UIKit

class KeyConstant {
    
    // string
    static let symbolPageKeyTitle = "123"
    static let lomajiPageKeyTitle = "ABC"
    static let spaceKeyTitle = "PhahTaigi"
    static let hanloSwitchKeyTitleLo = "Lô"
    static let hanloSwitchKeyTitleHan = "漢"
    
    // icon
    static let shiftIconString = "\u{000021E7}"
    static let shiftLockIconString = "\u{000021EA}"
    static let backspaceIconString = "\u{0000232B}"
    static let enterIconString = "\u{000021B5}"
    
    // background color
    static let keyBackgroundColor: UIColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    static let keyHighlightedBackgroundColor: UIColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
    static let keySpecialBackgroundColor = keyHighlightedBackgroundColor
    static let keySpecialHighlightedBackgroundColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
    static let keyShiftedBackgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
    static let keyPopupBackgroundColor: UIColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    static let keyTitleColor: UIColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
    static let keySpaceTitleColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.07849957192)
    static let keyShiftedTitleColor: UIColor = keyBackgroundColor
    
    // title font size
    static let keyTextTitleFontSize: CGFloat = 20
    static let keyPopupTextTitleFontSize: CGFloat = 30
    static let keyIconTitleFontSize: CGFloat = 27
    static let keyIconSymbolPageTitleFontSize: CGFloat = 16
    static let keyIconLomajiPageTitleFontSize: CGFloat = 16
    static let keyIconHanloSwitchTitleFontSize: CGFloat = 20
    static let keySpaceTitleFontSize: CGFloat = 18
    
    // shape
    static let keyLayerCornerRadius: CGFloat = 6.0
    static let keyFakeGapWidth: CGFloat = 2.0
}
