
import Foundation

class CurrentSetting {
    
    static func isPoj() -> Bool {
        return UserDefaults.standard.bool(forKey: SettingView.keyPreferredPoj)
    }
    
    static func isKeyInVibrationEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: SettingView.keyKeyInVibration)
    }
}
