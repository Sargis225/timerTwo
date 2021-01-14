//
//  ViewController.swift
//  timerTwo
//
//  Created by Saq on 1/7/21.
//

import UIKit
enum GameDifficulty {
    case easy
    case averange
    case root
    case percent
    case hard
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var settingsButton: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lavelNamesArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indent = "lavelsIndent"
        let cell = tableView.dequeueReusableCell(withIdentifier: indent) as! LavelsTableViewCell
        cell.textLabel?.text = lavelNamesArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        cell.textLabel?.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        cell.textLabel?.adjustsFontSizeToFitWidth = .init()
        cell.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.layer.cornerRadius = 20
        cell.recordLabel.text = "\(record) - "
        return cell
    }
    
    var lavelNamesArray:[String] = []
    var ident = ""
    var gamePlay:GameDifficulty!
    var gameType = GameDifficulty.self
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ident = "goGameIdent"
        
        switch indexPath.row {
        case 0:
            gamePlay = gameType.easy
        case 1:
            gamePlay = gameType.averange
        case 2:
            gamePlay = gameType.root
        case 3:
            gamePlay = gameType.percent
        case 4:
            gamePlay = gameType.hard
        case 5:
            performSegue(withIdentifier: "chooseTheAnswerIdent", sender: nil)
            return
        default:
            print("ok")
        }
        performSegue(withIdentifier: "goGameIdent", sender: gamePlay)
    }
    
    @IBOutlet var lavelTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsButton.layer.cornerRadius = 20
        lavelTableView.delegate = self
        lavelTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
   
    var record = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let colors = UserDefaults.standard.colorForKey(key: "colorsKey") {
            view.backgroundColor = colors
            lavelTableView.backgroundColor = colors
            settingsButton.backgroundColor = colors
        }
        lavelTableView.reloadData()
        let language = UserDefaults.standard.string(forKey: "languageKey")
        switch language {
        case "English":
            lavelNamesArray = ["EASY","BRACKET OPERATION","ROOT","PERCENT","HARD","Choose the answer"]
            record = "Record"
        case "Հայերեն":
            lavelNamesArray = ["Հեշտ","Փակագիծ","Արմատ","Տոկոս","Դժվար","yntreq patasxany"]
            record = "Ռեկորդ"
        case "Русский":
            lavelNamesArray = ["Легко","Операция скобки","Корен","Проценты","Трудно","vibirayte otvet"]
            record = "Рекорд"
        default:
            print("ok")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? EasyViewController {
            if ident == "goGameIdent" {
                vc.gameType = gamePlay
            }
        }
    }
}

