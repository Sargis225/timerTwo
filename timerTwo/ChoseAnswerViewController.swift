//
//  ChoseAnswerViewController.swift
//  timerTwo
//
//  Created by Saq on 1/17/21.
//

import UIKit

class ChoseAnswerViewController: UIViewController {

    @IBOutlet var randomActionLabel: UILabel!
    @IBOutlet var corectAnswerButtonsCollection: [UIButton]!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var correctAnswerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in corectAnswerButtonsCollection {
            i.layer.cornerRadius = 25
            i.layer.borderWidth = 3
            i.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        randomActionLabel.layer.masksToBounds = true
        correctAnswerLabel.layer.masksToBounds = true
        randomActionLabel.layer.cornerRadius = 20
        randomActionLabel.layer.borderWidth = 3
        randomActionLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        correctAnswerLabel.layer.cornerRadius = 20
        correctAnswerLabel.layer.borderWidth = 3
        correctAnswerLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        if let colors = UserDefaults.standard.colorForKey(key: "colorsKey") {
            view.backgroundColor = colors
        }
        let language = UserDefaults.standard.string(forKey: "languageKey")
        switch language {
        case "English":
           correctAnswerName = "Correct answer"
           youLostName = "You lost"
           refrshName = "Try again"
            exitName = "Exit"
        case "Հայերեն":
            correctAnswerName = "Ճիշտ պատասխան"
            youLostName = "Պարտվեցիք"
            refrshName = "Կրկին փորձել"
            exitName = "Դուրս գալ"
        case "Русский":
            correctAnswerName = "Правильный ответ"
            youLostName = "Ты проиграла"
            refrshName = "Попробовать снова"
            exitName = "Выйти"
        default:
            print("ok")
        }
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 10)
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        time()
         result = Int(actions[index!].0(firstNum!,secondNum!))
        var ereqTveriArray:[String] = [String(firstNum!),String(secondNum!),String(result)]
         correctAnswer = ereqTveriArray.randomElement()!
        for i in 0...ereqTveriArray.count - 1 {
            if ereqTveriArray[i] == correctAnswer {
               ereqTveriArray[i] = "?"
            }
        }
        randomActionLabel.text = "\(ereqTveriArray[0])\(actions[index!].1)\(ereqTveriArray[1]) = \(ereqTveriArray[2])"
        corectAnswerButtonsCollection.randomElement()?.setTitle(correctAnswer, for: .normal)
        
        for i in 0...corectAnswerButtonsCollection.count - 1 {
            corectAnswerButtonsCollection[i].titleLabel?.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            corectAnswerButtonsCollection[i].titleLabel?.textAlignment = .center
            corectAnswerButtonsCollection[i].titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            if corectAnswerButtonsCollection[i].titleLabel?.text == nil {
                corectAnswerButtonsCollection[i].setTitle(String(arrayOne.randomElement()!!), for: .normal)
            }
        }
        
    }
    
    
    var firstNum = (2...10).randomElement()
    var secondNum = (2...20).randomElement()
    let actions:[((Int,Int) -> Int,String)] = [((+), "+"), ((-), "-"), ((*), "*"), ((/), "/")]
    var result = 0
    var correctAnswer = ""
    var arrayOne = [(0...10).randomElement(),(11...19).randomElement(),(20...29).randomElement(),(30...39).randomElement()]
    var index = (0...2).randomElement()
    var correctAnswerCount = 0
    var correctAnswerName = ""
    var youLostName = ""
    var refrshName = ""
    var exitName = ""
    var counter:Float = 0.0
    var timer = Timer()

    
    func randomEllement(but:UIButton) {
        if but.titleLabel?.text == correctAnswer {
            correctAnswerCount += 1
            UserDefaults.standard.set(correctAnswerCount,forKey: "choseTheAnswerRecordCountKey")
            correctAnswerLabel.text = "\(correctAnswerName) - \(correctAnswerCount)"
            counter = 0.0
            time()
            progressView.setProgress(counter / 5, animated: false)
            for i in 0...corectAnswerButtonsCollection.count - 1 {
                if corectAnswerButtonsCollection[i].titleLabel?.text != but.titleLabel?.text {
                    corectAnswerButtonsCollection[i].setTitle(String(arrayOne.randomElement()!!), for: .normal)
                    but.setTitle(String(arrayOne.randomElement()!!), for: .normal)
                }
            }
            firstNum = (2...10).randomElement()
            secondNum = (2...10).randomElement()
            if firstNum == secondNum {
                secondNum! += 1
            }
            index = (0...2).randomElement()
            let result = Int(actions[index!].0(firstNum!,secondNum!))
            var ereqTveriArray:[String] = [String(firstNum!),String(secondNum!),String(result)]
            correctAnswer = ereqTveriArray.randomElement()!
            for i in 0...ereqTveriArray.count - 1 {
                if ereqTveriArray[i] == correctAnswer {
                   ereqTveriArray[i] = "?"
                }
            }
            randomActionLabel.text = "\(ereqTveriArray[0])\(actions[index!].1)\(ereqTveriArray[1]) = \(ereqTveriArray[2])"
            corectAnswerButtonsCollection.randomElement()?.setTitle(correctAnswer, for: .normal)
        }
        else {
            but.backgroundColor = .red
            for i in corectAnswerButtonsCollection {
                if i.titleLabel?.text == correctAnswer {
                    i.backgroundColor = #colorLiteral(red: 0.0239027201, green: 1, blue: 0, alpha: 1)
                }
            }
            alert(button: but)
        }
    }
    
    func alert(button:UIButton) {
        let alertController = UIAlertController(title: "\(youLostName)", message: "\(correctAnswerName) - \(correctAnswerCount)", preferredStyle: .alert)
        let alerActionOne = UIAlertAction(title: "Refresh", style: .default) { [self]action -> Void  in
            self.counter = 0
            self.time()
            self.progressView.setProgress(self.counter / 5, animated: false)
            button.backgroundColor = .darkGray
            for i in self.corectAnswerButtonsCollection {
                if i.titleLabel?.text == self.correctAnswer {
                    i.backgroundColor = .darkGray
                }
            }
            self.correctAnswerCount = 0
            self.correctAnswerLabel.text = ""
            firstNum = (2...10).randomElement()
            secondNum = (2...10).randomElement()
            if firstNum == secondNum {
                secondNum! += 1
            }
            index = (0...2).randomElement()
            let result = Int(actions[index!].0(firstNum!,secondNum!))
            var ereqTveriArray:[String] = [String(firstNum!),String(secondNum!),String(result)]
            correctAnswer = ereqTveriArray.randomElement()!
            for i in 0...ereqTveriArray.count - 1 {
                if ereqTveriArray[i] == correctAnswer {
                   ereqTveriArray[i] = "?"
                }
            }
            randomActionLabel.text = "\(ereqTveriArray[0])\(actions[index!].1)\(ereqTveriArray[1]) = \(ereqTveriArray[2])"
            corectAnswerButtonsCollection.randomElement()?.setTitle(correctAnswer, for: .normal)
        }
        let alertActionTwo = UIAlertAction(title: "Exit", style: .cancel) { action -> Void in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alertController.addAction(alerActionOne)
        alertController.addAction(alertActionTwo)
        present(alertController, animated: true, completion: nil)
        timer.invalidate()
    }
    
    func time() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    
    @objc func timerAction() {
        counter += 0.003
        progressView.setProgress(counter , animated: true)
        if counter >= 1 {
            timer.invalidate()
            let alertController = UIAlertController(title: "\(youLostName)", message: "\(correctAnswerName) - \(correctAnswerCount)", preferredStyle: .alert)
            let alerActionOne = UIAlertAction(title: "\(refrshName)", style: .default) {action -> Void  in
                self.counter = 0
                self.time()
                self.progressView.setProgress(self.counter / 5, animated: false)
                self.correctAnswerCount = 0
                self.correctAnswerLabel.text = ""
            }
            let alertActionTwo = UIAlertAction(title: "\(exitName)", style: .cancel) { action -> Void in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alertController.addAction(alerActionOne)
            alertController.addAction(alertActionTwo)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func corectAnswerOnePressed(_ sender: UIButton) {
        randomEllement(but: sender)
    }
    
    @IBAction func correctAnswerTwoPressed(_ sender: UIButton) {
        randomEllement(but: sender)

    }
    
    @IBAction func correctAnswerThird(_ sender: UIButton) {
        randomEllement(but: sender)

    }
    
    @IBAction func correctAnswerFourth(_ sender: UIButton) {
        randomEllement(but: sender)
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

