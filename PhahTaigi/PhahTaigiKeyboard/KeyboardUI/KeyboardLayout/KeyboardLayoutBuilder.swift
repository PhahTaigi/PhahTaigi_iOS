
import UIKit

class KeyboardLayoutFactory {
    
    public static func build(layoutKeyCodes: [[String]]) -> UIStackView {
        var rowViews = [UIStackView]()
        
        for (i, rowLayoutKeyCodes) in layoutKeyCodes.enumerated() {
            print("i=\(i)")
            let rowView = buildRowView(rowLayoutKeyCodes: rowLayoutKeyCodes)
            rowViews.append(rowView)
        }
        
        return buildColumnView(rowViews: rowViews)
    }
    
    private static func buildRowView(rowLayoutKeyCodes: [String]) -> UIStackView {
        let rowStackView = UIStackView.init()
        rowStackView.spacing = 5
        rowStackView.axis = .horizontal
        rowStackView.alignment = .fill
        rowStackView.distribution = .fillEqually
        
        for keyCode in rowLayoutKeyCodes {
            rowStackView.addArrangedSubview(createButtonWithTitle(title: keyCode))
        }
        
        return rowStackView
    }
    
    private static func buildColumnView(rowViews: [UIStackView]) -> UIStackView {
        let columnStackView = UIStackView.init()
        columnStackView.spacing = 5
        columnStackView.axis = .vertical
        columnStackView.alignment = .fill
        columnStackView.distribution = .fillEqually
        
        for rowView in rowViews {
            columnStackView.addArrangedSubview(rowView)
        }
        
        return columnStackView
    }
    
    private static func createButtonWithTitle(title: String) -> KeyboardButton {
        let button = KeyboardButton(type: .system)
        
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        // button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        // button.setTitleColor(UIColor.darkGray, for: .normal)
        
        return button
    }
}
