
import Foundation
import UIKit

class SelectionViewLayout {
    
    fileprivate static let inputDisplayViewWidthInset: CGFloat = 5
    
    static func build(selectionView: SelectionView) {
        let inputDisplayViewHeight: CGFloat = selectionView.frame.size.height / 100 * KeyboardViewConstant.selectionInputViewHeightPercentage
        let candidateWordViewHeight: CGFloat = selectionView.frame.size.height / 100 * KeyboardViewConstant.selectionCandidateViewHeightPercentage
        
        selectionView.inputDisplayView = InputDisplayView(frame: CGRect(x:inputDisplayViewWidthInset,
                                                                        y:0,
                                                                        width:selectionView.frame.size.width - inputDisplayViewWidthInset,
                                                                        height: inputDisplayViewHeight))
        selectionView.candidateWordView = CandidateWordView(frame: CGRect(x:0,
                                                                          y:inputDisplayViewHeight,
                                                                          width:selectionView.frame.size.width,
                                                                          height: candidateWordViewHeight))
        selectionView.menuBarView = MenuBarView(parentView: selectionView.candidateWordView!)
        
        selectionView.addSubview(selectionView.inputDisplayView!)
        selectionView.addSubview(selectionView.candidateWordView!)
        
        selectionView.addSubview(selectionView.menuBarView!)
        selectionView.addConstraintsWithFormatString(formate: "H:|[v0]|", views: selectionView.menuBarView!)
        selectionView.addConstraintsWithFormatString(formate: "V:|[v0]|", views: selectionView.menuBarView!)
    }
}
