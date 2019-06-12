
import UIKit

class CandidateWordView: UICollectionView {
    
    fileprivate var flowLayout: UICollectionViewFlowLayout
    
    fileprivate var lomajiCandidates = [String]()
    fileprivate var hanloCandidates = [ImeDict]()
    
    // callback function
    var onSelectedCandidate: ((_ selectedOutput: String, _ selectedHanloCandidate: ImeDict?)->())?
    
    init(frame: CGRect) {
        self.flowLayout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: self.flowLayout)
        
        self.decelerationRate = .init(rawValue: 0.01)
        
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delaysContentTouches = false
        
        self.dataSource = self
        self.delegate = self
        self.register(UINib.init(nibName: "CandidateWordCell", bundle: nil), forCellWithReuseIdentifier: "CandidateWordCell")
        
        self.flowLayout.scrollDirection = .horizontal
        self.flowLayout.minimumLineSpacing = 0
        self.flowLayout.estimatedItemSize = CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCandidates(lomajiCandidates: [String], hanloCandidates: [ImeDict]) {
        self.lomajiCandidates.removeAll()
        self.lomajiCandidates.append(contentsOf: lomajiCandidates)
        self.hanloCandidates.removeAll()
        self.hanloCandidates.append(contentsOf: hanloCandidates)
        
        // reset scroll
        let offset: CGPoint = CGPoint(x: -self.contentInset.right, y: 0)
        self.setContentOffset(offset, animated: false)
        
        self.reloadData()
        self.collectionViewLayout.invalidateLayout()
    }
    
    func getDefaultCandidate() -> String? {
        if self.lomajiCandidates.count == 0 {
            return nil
        } else {
            return self.lomajiCandidates[0]
        }
    }
    
    func clearCandidates() {
        self.lomajiCandidates.removeAll()
        self.hanloCandidates.removeAll()
        
        self.reloadData()
        self.collectionViewLayout.invalidateLayout()
    }
    
    func reloadByHanloStatus() {
        self.reloadData()
        self.collectionViewLayout.invalidateLayout()
    }
}

extension CandidateWordView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.lomajiCandidates.count + self.hanloCandidates.count
//        print("candidates count: \(count)")
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CandidateWordCell", for: indexPath) as! CandidateWordCell
        
        if indexPath.row < lomajiCandidates.count {
            let index = indexPath.row
            cell.topLabel.text = self.lomajiCandidates[index]
            cell.bottomLabel.text = ""
        } else {
            let index = indexPath.row - self.lomajiCandidates.count
            let currentImeDict: ImeDict = self.hanloCandidates[index]
            
//            print("currentImeDict.tailo: \(currentImeDict.tailo)")
            
            if CurrentKeyboardStatus.hanloStatus == .lomaji {
                if CurrentSetting.isPoj() {
                    cell.topLabel.text = currentImeDict.poj.trimmingCharacters(in: .whitespaces)
                } else {
                    cell.topLabel.text = currentImeDict.tailo.trimmingCharacters(in: .whitespaces)
                }
                
                cell.bottomLabel.text = currentImeDict.hanji.trimmingCharacters(in: .whitespaces)
            } else {
                cell.topLabel.text = currentImeDict.hanji.trimmingCharacters(in: .whitespaces)
                
                if CurrentSetting.isPoj() {
                    cell.bottomLabel.text = currentImeDict.poj.trimmingCharacters(in: .whitespaces)
                } else {
                    cell.bottomLabel.text = currentImeDict.tailo.trimmingCharacters(in: .whitespaces)
                }
            }
        }
        
        return cell
    }
}

extension CandidateWordView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell!.contentView.backgroundColor = KeyboardViewConstant.candidateWordCellHighlightBackgroundColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell!.contentView.backgroundColor = UIColor.clear
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < lomajiCandidates.count {
            let index = indexPath.row
            
            let selectedOutput = self.lomajiCandidates[index]
            self.onSelectedCandidate?(selectedOutput, nil)
        } else {
            let imeDictIndex = indexPath.row - self.lomajiCandidates.count
            
            var selectedOutput: String
            let selectedImeDictModel: ImeDict = self.hanloCandidates[imeDictIndex]
            if CurrentKeyboardStatus.hanloStatus == .lomaji {
                if CurrentSetting.isPoj() {
                    selectedOutput = selectedImeDictModel.poj
                } else {
                    selectedOutput = selectedImeDictModel.tailo
                }
            } else {
                selectedOutput = selectedImeDictModel.hanji
            }
            
            self.onSelectedCandidate?(selectedOutput, selectedImeDictModel)
        }
    }
}
