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
        // #TODO: kloracnel komponentnery
        counter = Int(UserDefaults.standard.string(forKey: "timeIntervalKey") ?? "") ?? 0
        if action == "%" {
//            print("aaa")
            for i in 30...1000 {
                if i % 100 == 0 {
                    percentNum.append(Int(i))
                }
            }
            for i in 1...100 {
                if i % 10 == 0 {
                    percent.append(Int(i))
                }
            }
        }
        
        time()
        if let colors = UserDefaults.standard.colorForKey(key: "colorsKey") {
            view.backgroundColor = colors
        }
//        switch gameDifficulty {
//        case .easy:
//            <#code#>
//        case .averange: {
//
//        }
//        default:
//            <#code#>
//        }
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var resultTextField: UITextField!
    @IBOutlet var actionLabel: UILabel!
    @IBOutlet var correctAnswerLabel: UILabel!
    @IBOutlet var wrongAnswerLabel: UILabel!
    var firstNum = 0
    var secondNum = 0
    var thirdNum = 0
    var counter = 60
    var timer = Timer()
    let actions:[((Int,Int) -> Int,String)] = [((+), "+"), ((-), "-"), ((*), "*"), ((/), "/")]
    var percent:[Int] = []
    var percentNum:[Int] = []
    var action = ""
    var gorcoxutyanIndexPakagciMej = 0
    let rootNumbers = [1,4,9,16,25,36,49,64,81,100,121,144,169,196,225,256,289,324,361,400,625]
    var gorcoxutyanIndex = 0
    var correctAnswerCount = 0
    var wrongAnswerCount = 0
    var rowResult = 0
    var gameDifficulty:GameDifficulty!
    
    @IBAction func resultTextFieldAction(_ sender: UITextField) {
        rowResult = Int(sender.text ?? "") ?? 0
        UserDefaults.standard.set(sender.text,forKey: actionLabel.text ?? "")
        switch action  {
        case "(":
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
        case "%":
            if (Double(sender.text ?? "") ?? 0) == hashviTokos(st: actionLabel.text ?? "").0!{
                correctAnswerCount += 1
                correctAnswerLabel.text = String(correctAnswerCount)
                randomEllement()
                
            }
            else {
                wrongAnswerCount += 1
                wrongAnswerLabel.text = String(wrongAnswerCount)
                randomEllement()
                sender.text = ""
            }
        
        case "√":
            if (Int(sender.text!) ?? 0).qarakusin == firstNum{
                correctAnswerCount += 1
                correctAnswerLabel.text = String(correctAnswerCount)
                randomEllement()
            }
            else {
                wrongAnswerCount += 1
                wrongAnswerLabel.text = String(wrongAnswerCount)
                randomEllement()
                sender.text = ""
                
            }
        
        case "":
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
        default:
            print("ok")
        }
    }
    
    func randomEllement() {
        gorcoxutyanIndex = Int.random(in: 0...2)
        switch action  {
        case "(":
            firstNum = (0...10).randomElement()!
            secondNum = (0...10).randomElement()!
            thirdNum = (0...10).randomElement()!
            gorcoxutyanIndexPakagciMej = Int.random(in: 0...2)
            actionLabel.text = "\(firstNum)\(actions[gorcoxutyanIndex].1)(\(secondNum)\(actions[gorcoxutyanIndexPakagciMej].1)\(thirdNum))"
            UserDefaults.standard.set("\(firstNum)\(actions[gorcoxutyanIndex].1)(\(secondNum)\(actions[gorcoxutyanIndexPakagciMej].1)\(thirdNum))",forKey: String(correctAnswerCount + wrongAnswerCount))
        case "%":
            firstNum = percentNum.randomElement()!
            secondNum = percent.randomElement()!
            actionLabel.text = "\(firstNum)\(actions[gorcoxutyanIndex].1)\(secondNum)%"
            UserDefaults.standard.set("\(firstNum)\(actions[gorcoxutyanIndex].1)\(secondNum)%",forKey: String(correctAnswerCount + wrongAnswerCount))
        case "√":
            firstNum = rootNumbers.randomElement()!
            actionLabel.text = "√(\(firstNum))"
            UserDefaults.standard.set("√(\(firstNum))", forKey: String(correctAnswerCount + wrongAnswerCount))
        case "":
            if 0...10 ~= firstNum{
                firstNum = (0...10).randomElement()!
                secondNum = (0...10).randomElement()!
                actionLabel.text = "\(firstNum)\(actions[gorcoxutyanIndex].1)\(secondNum)"
                UserDefaults.standard.set("\(firstNum)\(actions[gorcoxutyanIndex].1)\(secondNum)",forKey: String(correctAnswerCount + wrongAnswerCount))
            }
            if 11...20 ~= firstNum{
                firstNum = (11...20).randomElement()!
                secondNum = (11...20).randomElement()!
                actionLabel.text = "\(firstNum)\(actions[gorcoxutyanIndex].1)\(secondNum)"
                UserDefaults.standard.set("\(firstNum)\(actions[gorcoxutyanIndex].1)\(secondNum)",forKey: String(correctAnswerCount + wrongAnswerCount))
            }
        default:
            print("qo asacna")
        }
    }
    
    @IBAction func sbrosPressed(_ sender: UIButton) {
        time()
        refresh()
    }
    
    func refresh() {
        counter = Int(UserDefaults.standard.string(forKey: "timeIntervalKey") ?? "") ?? 0
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
                  return (nil, "tiv@ chi bajanvum 0-i ")
               }
        }
        else {
            let componentsArajinArjeq = hashviBazBajGum(str: "\(String(components[0]))")
            if componentsArajinArjeq.1 == nil  {
                 gumarmanArjeqner.append(String(componentsArajinArjeq.0!))
            }
            else {
               return (nil, "tiv@ chi bajanvum 0-i ")
            }
        }
        if components.count > 1 {
                for i in 1 ... components.count - 1 {
                let arjeqner = hashviBazBajGum(str: "-\(components[i])")
                    if arjeqner.1 == nil  {
                        gumarmanArjeqner.append(String(arjeqner.0!))
                    }
                    else {
                        return (nil, "tiv@ chi bajanvum 0-i ")
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
            for m in 1...compBaj.count - 1 {
                if Double(compBaj[m]) == 0 {
                   return (nil, "tiv@ chi bajanvum 0-i ")
                }
                 gorcoxutyanArjeq = gorcoxutyanArjeq / (Double(compBaj[m]) ?? 0)
                }
            sumBaz = sumBaz * gorcoxutyanArjeq
        }
        return (sumBaz, nil)
    }
    func hashviTokos (st:String) -> (Double? ,String? ) {
        let componentsTokos = st.split(separator: "%")
        var tokos:Double = 1
        var componentsLastCount = 0
        var datark = ""
        var merUzac = ""
        for i in componentsTokos {
            let comp = i.components(separatedBy: ["+","-","*","/"])
            if comp.count == 1 {
                return (nil, "greq te vor tvi qani tokosn eq cankanum hashvel")
            }
            componentsLastCount = ((comp.last?.count ?? 0 ) + 2)
            merUzac = String(st.suffix(componentsLastCount))
            let arandzTokos = st.replacingOccurrences(of: merUzac, with: "")
            let ardyunq = hashviObshin(str: arandzTokos)
            if ardyunq.1 == nil  {
                datark = String(ardyunq.0!)
            }
            else {
                return (nil, "tiv@ chi bajanvum 0-i ")
            }
        }
        let tokosiComp = merUzac.split(separator: "%")
        let tokosComponentsFirst = String(tokosiComp[0]).first
        
        if tokosComponentsFirst == "+" {
            let gumareluTokos = merUzac.components(separatedBy: ["+","%"])
            if (Double(gumareluTokos[1]) ?? 0) == 0 {
                return (nil, "tivy chi bajanvum 0-i")
            }
            let gumareluTokosDoublev = Double(gumareluTokos[1]) ?? 0
            let arajiArdyunq = Double(datark) ?? 0
            tokos = arajiArdyunq + ((arajiArdyunq * gumareluTokosDoublev) / 100)
            return (tokos, nil)
        }
        if tokosComponentsFirst == "-" {
            let gumareluTokos = merUzac.components(separatedBy: ["-","%"])
            if (Double(gumareluTokos[1]) ?? 0) == 0 {
                return (nil, "tivy chi bajanvum 0-i")
            }
            let gumareluTokosDoublev = Double(gumareluTokos[1]) ?? 0
            let arajiArdyunq = Double(datark) ?? 0
            tokos = arajiArdyunq - ((arajiArdyunq * gumareluTokosDoublev) / 100)
            return (tokos, nil)
        }
        if tokosComponentsFirst == "/" {
            let gumareluTokos = merUzac.components(separatedBy: ["/","%"])
            if (Double(gumareluTokos[1]) ?? 0) == 0 {
                return (nil, "tivy chi bajanvum 0-i")
            }
            let gumareluTokosDoublev = Double(gumareluTokos[1]) ?? 0
            let arajiArdyunq = Double(datark) ?? 0
            tokos = (arajiArdyunq * 100) / Double(gumareluTokosDoublev)
            return (tokos, nil)
        }
        merUzac = datark + String(tokosiComp[0])
        let verjnakanArdyunq = hashviObshin(str: merUzac)
       if verjnakanArdyunq.1 == nil  {
           tokos = verjnakanArdyunq.0! / 100
       }
       else {
           return (nil, "tiv@ chi bajanvum 0-i ")
       }
     return (tokos,nil)
    }
    func hashviMiPakagcovArjeq(st:String) ->(Double) {
        var arjeq:Double = 0
    //    var pakagciMijiArjeq = matchesForRegexInText(regex: regex, text: st).joined()
        var comp = st.components(separatedBy: ["("])
        comp[1].removeLast()
        comp[1] = String(hashviObshin(str: comp[1]).0!)
        let new = comp.joined()
        if new.contains("*-") == true{
            let newNew = new.replacingOccurrences(of: "*-", with: "*")
            arjeq = -hashviObshin(str: newNew).0!
        }
        if comp.joined().contains("--") {
          let hashvelun = comp.joined().replacingOccurrences(of: "--", with: "+")
            arjeq = hashviObshin(str: hashvelun).0!
        }else {
            arjeq = hashviObshin(str: comp.joined()).0!
        }
       
        return arjeq
    }
}
extension Int {
    var qarakusin:Int {
        return self * self
    }
}
