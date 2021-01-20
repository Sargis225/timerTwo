//
//  SettingsViewController.swift
//  timerTwo
//
//  Created by Saq on 1/14/21.
//

import UIKit
enum Setting {
    case language
    case color
}
class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var setting:Setting!
    
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
        cell.hideSlider()
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
    var settingsType = Setting.self
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            setting = settingsType.color
            performSegue(withIdentifier: "colorsIdent", sender: setting)
        }
        if indexPath.section == 1  {
            let cell = tableView.cellForRow(at: indexPath) as! SettingsTableViewCell
            cell.textLabel?.text = ""
            cell.showSlider()
        }
        if indexPath.section == 2  {
            setting = settingsType.language
            performSegue(withIdentifier: "colorsIdent", sender: setting)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ColorsTableViewController {
            vc.settings = setting
        }
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
