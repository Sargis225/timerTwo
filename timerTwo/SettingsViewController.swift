//
//  SettingsViewController.swift
//  timerTwo
//
//  Created by Saq on 1/14/21.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    var gameTime = ""
    var selectColor = ""
    var selectLanguage = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingsTableView.reloadData()
        let language = UserDefaults.standard.string(forKey: "languageKey")
        switch language {
        case "English":
            gameTime = "Select game time"
            selectColor = "Select background color"
            selectLanguage = "Select language"
        case "Հայերեն":
            gameTime = "Ընտրեք ժամանակը"
            selectColor = "Ընտրեք ետնագույնը"
            selectLanguage = "Ընտրեք Լեզուն"
        case "Русский":
            gameTime = "Выбирайте время игры"
            selectColor = "Выбирайте цвет"
            selectLanguage = "Выбирайте язык"
        default:
            print("ok")
        }

        
        if let colors = UserDefaults.standard.colorForKey(key: "colorsKey") {
            view.backgroundColor = colors
            settingsTableView.backgroundColor = colors
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indent = "settingsIndetifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: indent) as! SettingsTableViewCell
        cell.layer.cornerRadius = 20
        cell.textLabel?.textAlignment = .center
        if let colors = UserDefaults.standard.colorForKey(key: "colorsKey") {
            cell.backgroundColor = colors
        }
        cell.textLabel?.textColor = #colorLiteral(red: 0.1635166837, green: 0.3035069983, blue: 1, alpha: 1)
        cell.textLabel?.font = .boldSystemFont(ofSize: 30)
        if indexPath.section == 0 {
            cell.textLabel?.text = selectColor
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            cell.textLabel?.text = gameTime
        }
        if indexPath.section == 2  {
            cell.textLabel?.text = selectLanguage
        }
        return cell
    }
    var label = UILabel()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "colorsIdent", sender: nil)
        }
        if indexPath.section == 1  {
            tableView.cellForRow(at: indexPath)?.textLabel?.text = ""
            let slider = UISlider(frame: CGRect(x: 5, y: 3, width: (tableView.cellForRow(at: indexPath)?.frame.width)!  - 60, height: (tableView.cellForRow(at: indexPath)?.frame.height)! ))
            slider.maximumValue = 100
            slider.minimumValue = 30
            slider.value = 60
            slider.addTarget(self, action: #selector(sliderActionTimeInterval), for: .allEvents)
            tableView.cellForRow(at: indexPath)?.addSubview(slider)
            label = UILabel(frame: CGRect(x: slider.frame.width + 10, y: slider.frame.origin.y + 10, width: 30, height: 30))
            label.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.text = String(Int(slider.value))
            tableView.cellForRow(at: indexPath)?.addSubview(label)
        }
        if indexPath.section == 2  {
            performSegue(withIdentifier: "languagesIdent", sender: nil)
        }
    }
    
    @objc func sliderActionTimeInterval(_ sender:UISlider) {
        label.text = String(Int(sender.value))
        UserDefaults.standard.set(label.text ?? "",forKey: "timeIntervalKey")
    }
    
    
    @IBOutlet var settingsTableView: UITableView!
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UserDefaults {
  func colorForKey(key: String) -> UIColor? {
    var colorReturnded: UIColor?
    if let colorData = data(forKey: key) {
      do {
        if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
          colorReturnded = color
        }
      } catch {
        print("Error UserDefaults")
      }
    }
    return colorReturnded
  }
  
  func setColor(color: UIColor?, forKey key: String) {
    var colorData: NSData?
    if let color = color {
      do {
        let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
        colorData = data
      } catch {
        print("Error UserDefaults")
      }
    }
    set(colorData, forKey: key)
  }
}
