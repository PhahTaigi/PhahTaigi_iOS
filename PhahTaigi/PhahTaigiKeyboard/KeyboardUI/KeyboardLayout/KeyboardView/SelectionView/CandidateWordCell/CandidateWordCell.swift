
import UIKit

class CandidateWordCell: UICollectionViewCell {

    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Addresses a separate issue and prevent auto layout warnings due to the temporary width constraint in the xib.
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Code below is needed to make the self-sizing cell work when building for iOS 12 from Xcode 10.0:
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}
