import UIKit

extension UISegmentedControl {
    /// Tint color doesn't have any effect on iOS 13.
    func fixOldStyleUnder13() {
        if #available(iOS 13.0, *) {
            // default
        } else {
            self.tintColor = UIColor.white
            self.layer.borderColor = UIColor.gray.cgColor
        }
    }
}
