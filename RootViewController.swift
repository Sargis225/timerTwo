//
//  RootViewController.swift
//  timerTwo
//
//  Created by Saq on 1/9/21.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     timer()
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet var timerLabel: UILabel!
    
    @IBOutlet var actionLabel: UILabel!
    
    @IBOutlet var resultTextField: UITextField!
    @IBOutlet var wrongAnswerLabel: UILabel!
    @IBOutlet var correctAnswerLabel: UILabel!
    
    var time = Timer()
    var counter = 10
    var correctAnswerCount = 0
    var wrongAnswerCount = 0
    var firstNum = 0
    var rootNumbers = [0,1,4,9,16,25,36,49,64,81,100,121,144,169,196,225,256,289,324,361,400,625]
    let armat:Character = "√"
    var gorcoxutyanIndex = 0

    func timer() {
        time.invalidate()
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        randomEllement()
        wrongAnswerLabel.text = "0"
        correctAnswerLabel.text = "0"
    }
    func randomEllement() {
        firstNum = rootNumbers.randomElement()!
        actionLabel.text = "\(armat)(\(firstNum))"
        UserDefaults.standard.set("\(armat)(\(firstNum))", forKey: String(correctAnswerCount + wrongAnswerCount))
    }
    
    
    
    
    @IBAction func resultTextFieldPressed(_ sender: UITextField) {
        UserDefaults.standard.set(sender.text,forKey: actionLabel.text ?? "")
        if (Int(sender.text!) ?? 0).qarakusin == firstNum{
            correctAnswerCount += 1
            correctAnswerLabel.text = String(correctAnswerCount)
            randomEllement()
        }else {
            wrongAnswerCount += 1
            wrongAnswerLabel.text = String(wrongAnswerCount)
            randomEllement()
        }
        sender.text = ""
    }
    
    func refresh() {
        counter = 60
        correctAnswerCount = 0
        correctAnswerLabel.text = "0"
        wrongAnswerCount = 0
        wrongAnswerLabel.text = "0"
    }
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        timer()
        refresh()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? HistoryViewController {
            if let dic = sender as? (Int) {
                vc.rowCount = dic
               
            }
        }
    }
    
    
    @objc func timeAction() {
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
            time.invalidate()
            let allRow = correctAnswerCount + wrongAnswerCount
            performSegue(withIdentifier: "histoyIdentRoot", sender: (allRow).self)
            print(correctAnswerCount)
        }
        timerLabel.text = "\(counter)"
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
extension Int {
    var qarakusin:Int {
        return self * self
    }
}
