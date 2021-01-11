//
//  BracketActionViewController.swift
//  timerTwo
//
//  Created by Saq on 1/8/21.
//

import UIKit

class BracketActionViewController: UIViewController {

    
    
    @IBOutlet var actionLabel: UILabel!
    @IBOutlet var resultTextFiled: UITextField!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var wrongAnswerLabel: UILabel!
    @IBOutlet var correctAnswerLabel: UILabel!
    var counter = 60
    var firstNum = 0
    var secondNum = 0
    var firthNum = 0
    var gorcoxutyanIndex = 0
    var gorcoxutyanIndexPakagciMej = 0
    var correctAnswerCount = 0
    var wrongAnswerCount = 0
    var message = ""
    var rowResult = 0
    var timer = Timer()
    let actions:[((Int,Int) -> Int,String)] = [((+), "+"),((*), "*") ,((-), "-") , ((/), "/")]
    
    func time() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        randomEllement()
        wrongAnswerLabel.text = "0"
        correctAnswerLabel.text = "0"
    }
    func randomEllement() {
        firstNum = (0...10).randomElement()!
        secondNum = (0...10).randomElement()!
        firthNum = (0...10).randomElement()!
        gorcoxutyanIndex = Int.random(in: 0...2)
        gorcoxutyanIndexPakagciMej = Int.random(in: 0...2)
        
        actionLabel.text = "\(firstNum)\(actions[gorcoxutyanIndex].1)(\(secondNum)\(actions[gorcoxutyanIndexPakagciMej].1)\(firthNum))"
        UserDefaults.standard.set("\(firstNum)\(actions[gorcoxutyanIndex].1)(\(secondNum)\(actions[gorcoxutyanIndexPakagciMej].1)\(firthNum))",forKey: String(correctAnswerCount + wrongAnswerCount))
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
            performSegue(withIdentifier: "historyIdent2", sender: (allRow,rowResult).self)
            print(correctAnswerCount)
        }
        timerLabel.text = "\(counter)"
    }

    
    @IBAction func resultTextFieldAction(_ sender: UITextField) {
        rowResult = Int(sender.text ?? "") ?? 0
        UserDefaults.standard.set(sender.text,forKey: actionLabel.text ?? "")
       
        if (Int(sender.text ?? "") ?? 0) == Int(hashviMiPakagcovArjeq(st: actionLabel.text ?? "")) {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? HistoryViewController {
            if let dic = sender as? (Int,Int) {
                vc.rowCount = dic.0
                vc.actionResult = dic.1
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time()
        // Do any additional setup after loading the view.
    }
    
    func refresh() {
        counter = 60
        correctAnswerCount = 0
        correctAnswerLabel.text = "0"
        wrongAnswerCount = 0
        wrongAnswerLabel.text = "0"
    }
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        time()
        refresh()
    }
    
    
    
    
    
    
    
    func hashviMiPakagcovArjeq(st:String) ->(Double) {
        var arjeq:Double = 0
    //    var pakagciMijiArjeq = matchesForRegexInText(regex: regex, text: st).joined()
        var comp = st.components(separatedBy: ["("])
        comp[1].removeLast()
        comp[1] = String(hashviObshin(str: comp[1]).0!)
//        comp.joined()
        if comp.joined().contains("--") {
          let hashvelun = comp.joined().replacingOccurrences(of: "--", with: "+")
            arjeq = hashviObshin(str: hashvelun).0!
        }else {
            arjeq = hashviObshin(str: comp.joined()).0!
        }
       
        return arjeq
    }
    let error = "texi e unecel sxal"
    let error0 = "tivy chi bajanvum 0-i"
    func hashviObshin (str:String) -> (Double?,String?) {
        if str == "" {
            return (0.0,"mutqagreq Arjeq")
        }
        var all:Double = 0
        let components = str.split(separator: "-")
        var gumarmanArjeqner:[String] = []
        if str.first == "-" {
            let componentsArajinArjeq = hashviBazBajGum(str: "-\(String(components[0]))")
               if componentsArajinArjeq.1 == nil  {
                gumarmanArjeqner.append(String(componentsArajinArjeq.0!))

               }
               else {
                  return (nil, error0)
               }
        }
        else {
            let componentsArajinArjeq = hashviBazBajGum(str: "\(String(components[0]))")
            if componentsArajinArjeq.1 == nil  {
                 gumarmanArjeqner.append(String(componentsArajinArjeq.0!))
            }
            else {
               return (nil, error0)
            }
        }
        if components.count > 1 {
                for i in 1 ... components.count - 1 {
                let arjeqner = hashviBazBajGum(str: "-\(components[i])")
                    if arjeqner.1 == nil  {
                        gumarmanArjeqner.append(String(arjeqner.0!))
                    }
                    else {
                        return (nil, error0)
                    }
                }
            let arajinArjeq = Double(gumarmanArjeqner[0]) ?? 0
            all = arajinArjeq
            for i in 1 ... gumarmanArjeqner.count - 1 {
                all = all - (-(Double(gumarmanArjeqner[i]) ?? 0))
            }
        }
        if gumarmanArjeqner.count == 1 {
            all = Double(gumarmanArjeqner[0]) ?? 0
        }
        return (all,nil)
    }
    func hashviBazBajGum (str: String) -> (Double? , String? ) {
        var all:Double = 0
        let componentsBazmapatkumBajanum = str.split(separator: "+")
        var arjeqner:[Double] = []

        for i in componentsBazmapatkumBajanum {
            if Double(i) == nil {
             let itog = hashvelBazmBaj(strBazBaj: String(i))
                if itog.1 == nil{
                    arjeqner.append(itog.0!)
                }
                else {
                    return (nil, "tiv@ chi bajanvum 0 - i ")
                }
            }
            else {
                arjeqner.append(Double(i) ?? 0)
            }
        }
        for i in arjeqner {
            all = all + Double(i)
        }
        return (all,nil)
    }
    func hashvelBazmBaj (strBazBaj: String) -> (Double? , String?) {
        var sumBaz:Double = 1
        let componentsBaz = strBazBaj.split(separator: "*")
        var componentsBajanum:[String.SubSequence] = []
            for i in componentsBaz {
                if i == "0"{
                sumBaz = 0
                }
                if let number = Double(i){
                    sumBaz = sumBaz * number
                }
                else {
                    componentsBajanum.append(i)
                }
            }
        for g in componentsBajanum {
            let compBaj = g.split(separator: "/")
            var gorcoxutyanArjeq = Double(compBaj[0]) ?? 0
            for m in 1 ... compBaj.count - 1 {
                if Double(compBaj[m]) == 0 {
                   return (nil, error)
                }
                 gorcoxutyanArjeq = gorcoxutyanArjeq / (Double(compBaj[m]) ?? 0)
                }
            sumBaz = sumBaz * gorcoxutyanArjeq
        }
        return (sumBaz, nil)
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
