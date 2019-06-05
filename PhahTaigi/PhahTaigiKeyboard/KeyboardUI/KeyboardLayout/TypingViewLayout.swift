
import Foundation
import UIKit

class TypingViewLayout {
    
    static func build(typingView: TypingView) {
        let count = KeyboardTemplate.taigiKeyboardTemplate.count
        
        for i in 0...count-1 {
            let pageView = PageView(frame: typingView.bounds)
            let keyboardTemplateModel = KeyboardTemplate.taigiKeyboardTemplate[i]
            
            if (i == 0) {
                pageView.isHidden = false
            } else {
                pageView.isHidden = true
            }
            typingView.pages.append(pageView)
            
            pageView.spacing = 0
            pageView.axis = .vertical
            pageView.alignment = .fill
            pageView.distribution = .fillEqually
            
            typingView.addSubview(pageView)
            
//            print("pageView \(i): \(pageView.frame.origin.x), \(pageView.frame.origin.y), \(pageView.frame.width), \(pageView.frame.height)")
            
            buildPageView(pageView: pageView, keyboardTemplateModel: keyboardTemplateModel)
        }
    }
    
    private static func buildPageView(pageView: PageView, keyboardTemplateModel: KeyboardTemplateModel) {
        let count = keyboardTemplateModel.halfwidthKeyCodes!.count
        let rowHeight: CGFloat = pageView.frame.height / CGFloat(count)
        
        for i in 0...count-1 {
            let y: CGFloat = rowHeight * CGFloat(i)
            let rowView = RowView(frame: CGRect(x: 0, y: y, width: pageView.frame.width, height: rowHeight))
            
            pageView.rowViews.append(rowView)
            pageView.addArrangedSubview(rowView)
            
//            print("rowView \(i): \(rowView.frame.origin.x), \(rowView.frame.origin.y), \(rowView.frame.width), \(rowView.frame.height)")
            
            buildRowView(rowIndex: i, rowView: rowView, keyboardTemplateModel: keyboardTemplateModel)
        }
    }
    
    private static func buildRowView(rowIndex: Int, rowView: RowView, keyboardTemplateModel: KeyboardTemplateModel) {
        let halfwidthKeyCodes: [String] = keyboardTemplateModel.halfwidthKeyCodes![rowIndex]
        let halfwidthKeyCodesShifted: [String] = keyboardTemplateModel.halfwidthKeyCodesShifted![rowIndex]
        let fullwidthKeyCodes: [String] = keyboardTemplateModel.fullwidthKeyCodes![rowIndex]
        let fullwidthKeyCodesShifted: [String] = keyboardTemplateModel.fullwidthKeyCodesShifted![rowIndex]
        let keysWidthPercentage: [CGFloat] = keyboardTemplateModel.keysWidthPercentage![rowIndex]
        
        let keyCountInRow = halfwidthKeyCodes.count
        var keyX: CGFloat = 0
        for i in 0..<keyCountInRow {
            let halfwidthKeyCode = halfwidthKeyCodes[i]
            let halfwidthKeyCodeShifted = halfwidthKeyCodesShifted[i]
            let fullwidthKeyCode = fullwidthKeyCodes[i]
            let fullwidthKeyCodeShifted = fullwidthKeyCodesShifted[i]
            let keyWidthPercentage = keysWidthPercentage[i]
            
            let keyWidth = rowView.frame.width / CGFloat(100) * keyWidthPercentage

            let frame = CGRect(x: keyX, y: 0, width: keyWidth, height: rowView.frame.height)
            let key = Key(halfwidthKeyCode: halfwidthKeyCode,
                          halfwidthKeyCodeShifted: halfwidthKeyCodeShifted,
                          fullwidthKeyCode: fullwidthKeyCode,
                          fullwidthKeyCodeShifted: fullwidthKeyCodeShifted)
            let keyView = KeyView.create(frame: frame, key: key)

            keyX += keyWidth

            rowView.keyViews.append(keyView)
            rowView.addSubview(keyView)
            
//            print("key \(i): \(key.frame.origin.x), \(key.frame.origin.y), \(key.frame.width), \(key.frame.height)")
        }
    }
}
