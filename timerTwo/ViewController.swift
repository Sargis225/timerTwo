//
//  ViewController.swift
//  timerTwo
//
//  Created by Saq on 1/7/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // #TODO: sarqel nastroykeqy
    
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
//        cell.textLabel?.font = UIFont(name: .init(), size: 60)
        cell.textLabel?.font = .boldSystemFont(ofSize: 26)

        cell.textLabel?.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.layer.cornerRadius = 20
        return cell
    }
    
    
    let lavelNamesArray = ["EASY","ACTION WITH PARENTHESES","ROOT","PERCENT","HARD"]
    var ident = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            ident = "easyIndent"
            performSegue(withIdentifier: ident, sender: (0...10))
        case 1:
            ident = "averangeIndent"
            performSegue(withIdentifier: "averangeIndent", sender: nil)
        case 2:
            ident = "rootIdent"
            performSegue(withIdentifier: "rootIdent", sender: nil)
        case 3:
            ident = "percentIndent"
            for i in 30...10000 {
                if i % 100 == 0 {
                    percentNum.append(Int(i))
                }
            }
            performSegue(withIdentifier: "percentIndent", sender: nil)
        case 4:
            ident = "hardIndent"
            performSegue(withIdentifier: ident, sender: (11...20))
        default:
            print("ok")
        }
    }
    
    @IBOutlet var lavelTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsButton.layer.cornerRadius = 20
        lavelTableView.delegate = self
        lavelTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let colors = UserDefaults.standard.colorForKey(key: "colorsKey") {
            view.backgroundColor = colors
            lavelTableView.backgroundColor = colors
            settingsButton.backgroundColor = colors
        }
    }
    
    let percent = [10,20,30,40,50,60,70,80,90,100]
    var percentNum:[Int] = []
    let rootNumbers = [1,4,9,16,25,36,49,64,81,100,121,144,169,196,225,256,289,324,361,400,625]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? EasyViewController {
            if ident == "hardIndent" {
                vc.firstNum = (11...20).randomElement()!
                vc.secondNum = (11...20).randomElement()!
            }
            if ident == "easyIndent" {
                vc.firstNum = (0...10).randomElement()!
                vc.secondNum = (0...10).randomElement()!
            }
            if ident == "percentIndent" {
                vc.firstNum = percentNum.randomElement()!
                vc.secondNum = percent.randomElement()!
//                vc.thirdNum = (100...1000).randomElement()!
                vc.action = "%"
            }
            if ident == "rootIdent" {
                vc.firstNum = rootNumbers.randomElement()!
                vc.action = "√"
            }
            if ident == "averangeIndent" {
                vc.firstNum = (0...10).randomElement()!
                vc.secondNum = (0...10).randomElement()!
                vc.thirdNum = (0...10).randomElement()!
                vc.action = "("

            }
            
        }
        
    }
    

}

