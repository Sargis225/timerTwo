//
//  EasyViewController.swift
//  timerTwo
//
//  Created by Saq on 1/7/21.
//

import UIKit

class EasyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time()
        // Do any additional setup after loading the view.
    }
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var resultTextField: UITextField!
    @IBOutlet var actionLabel: UILabel!
    @IBOutlet var correctAnswerLabel: UILabel!
    @IBOutlet var wrongAnswerLabel: UILabel!
    var firstNum = 0
    var secondNum = 0
    var counter = 10
    var timer = Timer()
    let actions:[((Int,Int) -> Int,String)] = [((+), "+"), ((-), "-"), ((*), "*"), ((/), "/")]
    var gorcoxutyanIndex = 0
    var correctAnswerCount = 0
    var wrongAnswerCount = 0
    var message = ""
    var rowResult = 0
    @IBAction func resultTextFieldAction(_ sender: UITextField) {
        rowResult = Int(sender.text ?? "") ?? 0
        UserDefaults.standard.set(sender.text,forKey: actionLabel.text ?? "")

        if (Int(sender.text ?? "") ?? 0) == actions[gorcoxutyanIndex].0(firstNum,secondNum) {
            correctAnswerCount += 1
            correctAnswerLabel.text = String(correctAnswerCount)
            randomEllement()
            sender.text = ""
        }
        else {
            wrongAnswerCount += 1
            wrongAnswerLabel.text = String(wrongAnswerCount)
            randomEllement()
            sender.text = ""
            
        }
    

    }
    
    func randomEllement() {
        if 0...10 ~= firstNum{
            firstNum = (0...10).randomElement()!
            secondNum = (0...10).randomElement()!
        }
        if 11...20 ~= firstNum{
            firstNum = (11...20).randomElement()!
            secondNum = (11...20).randomElement()!
        }
        gorcoxutyanIndex = Int.random(in: 0...2)
        actionLabel.text = "\(firstNum)\(actions[gorcoxutyanIndex].1)\(secondNum)"
        UserDefaults.standard.set("\(firstNum)\(actions[gorcoxutyanIndex].1)\(secondNum)",forKey: String(correctAnswerCount + wrongAnswerCount))
    }
    
    @IBAction func sbrosPressed(_ sender: UIButton) {
        time()
        refresh()
    }
    
    func refresh() {
        counter = 60
        correctAnswerCount = 0
        correctAnswerLabel.text = "0"
        wrongAnswerCount = 0
        wrongAnswerLabel.text = "0"
    }
    
    func time() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        randomEllement()
        wrongAnswerLabel.text = "0"
        correctAnswerLabel.text = "0"
    }
    
    
    @objc func timerAction() {
        counter -= 1
        if counter <= 5 {
            if (counter % 2) == 0 {
                view.backgroundColor = .white
            }
            else {
                view.backgroundColor = .black
            }
        }
        if counter < 1 {
            timer.invalidate()
            let allRow = correctAnswerCount + wrongAnswerCount
            performSegue(withIdentifier: "historyIdent", sender: (allRow,rowResult).self)
//            if wrongAnswerCount > correctAnswerCount {
//                message = "vata Shat vata hech lav chi :D"
//            }else{
//                message = "eli vochinch mecanas mard kdarnas"
//            }
//            let alertController = UIAlertController(title:"chisht - \(correctAnswerLabel.text ?? ""), sxal - \( wrongAnswerLabel.text ?? "")", message: message , preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "sksel noric", style: .default) {
//                action in
//                self.time()
//                self.refresh()
//            }
//            let alertAction2 = UIAlertAction(title: "veradarnal Naxord Ej", style: .default) {
//                action in
//                self.navigationController?.popViewController(animated: true)
//            }
//            alertController.addAction(alertAction)
//            alertController.addAction(alertAction2)
//            self.present(alertController, animated: false) {
//                print("show present")
//            }
//
            print(correctAnswerCount)
        }
        timeLabel.text = "\(counter)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? HistoryViewController {
            if let dic = sender as? (Int,Int) {
                vc.rowCount = dic.0
                vc.actionResult = dic.1
            }
        }
    }
    

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
