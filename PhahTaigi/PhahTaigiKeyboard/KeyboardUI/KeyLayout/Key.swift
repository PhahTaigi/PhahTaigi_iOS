
import Foundation
import UIKit

class Key {
    
    let halfwidthKeyCode: String
    let halfwidthKeyCodeShifted: String
    let fullwidthKeyCode: String
    let fullwidthKeyCodeShifted: String
    
    let keyType: KeyType
    
    init(halfwidthKeyCode: String, halfwidthKeyCodeShifted: String, fullwidthKeyCode: String, fullwidthKeyCodeShifted: String) {
        self.halfwidthKeyCode = halfwidthKeyCode
        self.halfwidthKeyCodeShifted = halfwidthKeyCodeShifted
        self.fullwidthKeyCode = fullwidthKeyCode
        self.fullwidthKeyCodeShifted = fullwidthKeyCodeShifted
        
        switch self.halfwidthKeyCode {
        case KeyType.shift.rawValue:
            self.keyType = .shift
            
        case KeyType.backspace.rawValue:
            self.keyType = .backspace
            
        case KeyType.symbolPage.rawValue:
            self.keyType = .symbolPage
            
        case KeyType.keyboardChange.rawValue:
            self.keyType = .keyboardChange
            
        case KeyType.space.rawValue:
            self.keyType = .space

        case KeyType.taibunSpace.rawValue:
            self.keyType = .taibunSpace
            
        case KeyType.engbunSpace.rawValue:
            self.keyType = .engbunSpace
            
        case KeyType.hanloSwitch.rawValue:
            self.keyType = .hanloSwitch
            
        case KeyType.enter.rawValue:
            self.keyType = .enter
            
        case KeyType.lomajiPage.rawValue:
            self.keyType = .lomajiPage
            
        default:
            self.keyType = .charactor
        }
    }
}
