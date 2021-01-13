//
//  ViewController.swift
//  timerTwo
//
//  Created by Saq on 1/7/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        cell.textLabel?.font = UIFont(name: .init(), size: 40)
        cell.textLabel?.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return cell
    }
    let lavelNamesArray = ["EASY","AVERAGE","ROOT","PERCENT","HARD"]
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "easyIndent", sender: nil)
        case 1:
            performSegue(withIdentifier: "averangeIndent", sender: nil)
        case 2:
            performSegue(withIdentifier: "rootIdent", sender: nil)
        case 3:
            performSegue(withIdentifier: "percentIndent", sender: nil)
        case 4:
            performSegue(withIdentifier: "hardIndent", sender: nil)
        default:
            print("ok")
        }
    }
    
    
    
    
    @IBOutlet var lavelTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lavelTableView.delegate = self
        lavelTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        a = 1
        b = 1
        print("02")
    }
    
    var a = 1
    var b = 1
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EasyViewController {
            if a == 2 {
            vc.firstNum = (0...10).randomElement()!
            vc.secondNum = (0...10).randomElement()!
            }
            if b == 2 {
            vc.firstNum = (10...20).randomElement()!
            vc.secondNum = (10...20).randomElement()!
            }
            
        }
    }
    @IBAction func easyLavelPressed(_ sender: UIButton) {
        a += 1
        print("easy")
    }

    @IBAction func hardLavelPressed(_ sender: Any) {
        b += 1
        print("hard")
    }
    

}

