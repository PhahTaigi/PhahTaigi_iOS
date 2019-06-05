
import Foundation

class CurrentKeyboardStatus {
    
    static var didChangedShiftStatus: (()->())?
    static var didChangedHanloStatus: (()->())?
    static var didShiftUnlock: (()->())?
    
    static var shiftStatus: ShiftStatus = .normal {
        didSet {
            self.didChangedShiftStatus?()
        }
    }

    static var hanloStatus: HanloStatus = .lomaji {
        didSet {
            self.didChangedHanloStatus?()
        }
    }
    
    static func switchShiftStatue() {
        switch self.shiftStatus {
        case .normal:
            self.shiftStatus = .shifted
        case .shifted:
            self.shiftStatus = .normal
        case .locked:
            self.shiftStatus = .normal
            self.didShiftUnlock?()
        }
    }
    
    static func switchHanloStatue() {
        switch self.hanloStatus {
        case .lomaji:
            self.hanloStatus = .hanji
        case .hanji:
            self.hanloStatus = .lomaji
        }
    }
}
