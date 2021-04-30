
import UIKit

class SettingView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    static let keyPreferredPoj = "SettingView.keyPreferredPoj"
    static let keyKeyInVibration = "SettingView.keyKeyInVibration"
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var effectsView: UIVisualEffectView?
    @IBOutlet var backButton: UIButton?
    @IBOutlet var settingsLabel: UILabel?
    @IBOutlet var pixelLine: UIView?
    
    static func registerDefaultSettings() {
        UserDefaults.standard.register(defaults: [SettingView.keyPreferredPoj: true,
                                                  SettingView.keyKeyInVibration: true
            ])
    }
    
    var settingsList: [(String, [String])] {
        get {
            return [
                ("一般設定", [SettingView.keyPreferredPoj]),
                ("進階設定", [SettingView.keyKeyInVibration])
            ]
        }
    }
    var settingsNames: [String:String] {
        get {
            return [
                SettingView.keyPreferredPoj: "使用白話字（台灣羅馬字）",
                SettingView.keyKeyInVibration: "Phah字ê時震動",
            ]
        }
    }
    var settingsNotes: [String: String] {
        get {
            return [
                SettingView.keyPreferredPoj: "文字使用百外冬歷史ê Pe̍h-ōe-jī。Nā無就是教育部羅馬拼音。",
                SettingView.keyKeyInVibration: "Phah字ê時ē震動，ē有較好ê phah字體驗，建議使用。\n（若beh使用，ài去輸入法設定，kā『允許完整存取權』phah--khui。）"
            ]
        }
    }
    
    required init() {
        super.init(frame: .zero)
        self.loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("loading from nib not supported")
    }
    
    func loadNib() {
        let assets = Bundle(for: type(of: self)).loadNibNamed("SettingView", owner: self, options: nil)
        
        if (assets?.count ?? 0) > 0 {
            if let rootView = assets?.first as? UIView {
                rootView.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(rootView)
                
                let left = NSLayoutConstraint(item: rootView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
                let right = NSLayoutConstraint(item: rootView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
                let top = NSLayoutConstraint(item: rootView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
                let bottom = NSLayoutConstraint(item: rootView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
                
                self.addConstraint(left)
                self.addConstraint(right)
                self.addConstraint(top)
                self.addConstraint(bottom)
            }
        }
        
        self.tableView?.register(SettingViewCell.self, forCellReuseIdentifier: "SettingViewCell")
        self.tableView?.estimatedRowHeight = 100;
        self.tableView?.rowHeight = UITableView.automaticDimension;
        
        // XXX: this is here b/c a totally transparent background does not support scrolling in blank areas
        self.tableView?.backgroundColor = UIColor.white.withAlphaComponent(0.01)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingsList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsList[section].1.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == self.settingsList.count - 1 {
            return 80
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.settingsList[section].0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingViewCell") as? SettingViewCell {
            let key = self.settingsList[indexPath.section].1[indexPath.row]
            
            if cell.sw.allTargets.count == 0 {
                cell.sw.addTarget(self, action: #selector(SettingView.toggleSetting(_:)), for: UIControl.Event.valueChanged)
            }
            
            cell.sw.isOn = UserDefaults.standard.bool(forKey: key)
            cell.label.text = self.settingsNames[key]
            cell.longLabel.text = self.settingsNotes[key]

            cell.changeConstraints()
            
            // fix UISwitch not respond
            cell.contentView.isUserInteractionEnabled = false
            
            return cell
        }
        else {
            assert(false, "this is a bad thing that just happened")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        if let textlabel = header.textLabel {
            textlabel.font = textlabel.font.withSize(18)
        }
    }
    
    @objc func toggleSetting(_ sender: UISwitch) {
        if let cell = sender.superview as? UITableViewCell {
            if let indexPath = self.tableView?.indexPath(for: cell) {
                let key = self.settingsList[indexPath.section].1[indexPath.row]
                UserDefaults.standard.set(sender.isOn, forKey: key)
            }
        }
    }
}

