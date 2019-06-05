
import Foundation
import UIKit

class KeyboardTemplateModel {
    
    var halfwidthKeyCodes: [[String]]?
    var halfwidthKeyCodesShifted: [[String]]?
    var fullwidthKeyCodes: [[String]]?
    var fullwidthKeyCodesShifted: [[String]]?
    
    var keysWidthPercentage: [[CGFloat]]?
    
    init(halfwidthKeyCodes: [[String]], halfwidthKeyCodesShifted: [[String]], fullwidthKeyCodes: [[String]], fullwidthKeyCodesShifted: [[String]], keysWidthPercentage: [[CGFloat]]) {
        self.halfwidthKeyCodes = halfwidthKeyCodes
        self.halfwidthKeyCodesShifted = halfwidthKeyCodesShifted
        self.fullwidthKeyCodes = fullwidthKeyCodes
        self.fullwidthKeyCodesShifted = fullwidthKeyCodesShifted
        
        self.keysWidthPercentage = keysWidthPercentage
    }
}
