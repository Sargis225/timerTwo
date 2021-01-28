//
//  HistoryViewController.swift
//  timerTwo
//
//  Created by Saq on 1/7/21.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    let armat:Character = "√"
    var wrong = ""
    var right = ""
    
    
    @IBOutlet var navigationHistoryBackButton: UINavigationItem!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        print("00")
        navigationController?.popToRootViewController(animated: false)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myHistoryTableView.reloadData()
        if let colors = UserDefaults.standard.colorForKey(key: "colorsKey") {
            view.backgroundColor = colors
            myHistoryTableView.backgroundColor = colors
        }
        let language = UserDefaults.standard.string(forKey: "languageKey")
        switch language {
        case "English":
            wrong = "wrong"
            right = "right"
        case "Հայերեն":
            wrong = "Սխալ"
            right = "Ճիշտ"
        case "Русский":
            wrong = "Неправильно"
            right = "Правильно"
        default:
            print("ok")
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indent = "cellIndentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: indent) as! MyTableViewCell
        if let colors = UserDefaults.standard.colorForKey(key: "colorsKey") {
            cell.backgroundColor = colors
        }
        cell.textLabel?.textColor = .white
        //        cell.actionIndexLabel.text = String(indexPath.row )
        cell.actionsLabel.text = UserDefaults.standard.string(forKey: String(indexPath.row )) ?? ""
        cell.resultLabel.text = UserDefaults.standard.string(forKey:cell.actionsLabel.text ?? "")
        
        if ((cell.actionsLabel.text?.contains("%")) == true) {
            if Double(cell.resultLabel.text ?? "") == hashviTokos(st: cell.actionsLabel.text ?? "").0! {
                cell.resultLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }else {
                cell.resultLabel.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.1083222023, blue: 0, alpha: 1)
                cell.resultLabel.text = "\(wrong):\(cell.resultLabel.text ?? ""),  \(right):\(String(Int(hashviTokos(st: cell.actionsLabel.text ?? "").0!)))"
            }
                return cell
        }
        if ((cell.actionsLabel.text?.contains(armat)) == false) &&  cell.actionsLabel.text?.contains("(") == false{
        if Double(cell.resultLabel.text ?? "") == hashviObshin(str: cell.actionsLabel.text ?? "").0! {
            cell.resultLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }else {
            cell.resultLabel.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.1083222023, blue: 0, alpha: 1)
            cell.resultLabel.text = "\(wrong):\(cell.resultLabel.text ?? ""),  \(right):\(String(Int(hashviObshin(str: cell.actionsLabel.text ?? "").0!)))"
        }
            return cell
        }
        
        if ((cell.actionsLabel.text?.contains(armat)) == true) {
            if cell.resultLabel.text == String(Int(hashviMitTvovArmat(st: cell.actionsLabel.text ?? ""))) {
                cell.resultLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }else {
                cell.resultLabel.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.1083222023, blue: 0, alpha: 1)
                cell.resultLabel.text = "\(wrong):\(cell.resultLabel.text ?? ""),  \(right):\(String(Int(hashviMitTvovArmat(st: cell.actionsLabel.text ?? ""))))"
            }
            return cell
        }
        if cell.actionsLabel.text?.contains("(") == true {
            if Double(cell.resultLabel.text ?? "") == hashviMiPakagcovArjeq(st: cell.actionsLabel.text ?? "") {
                cell.resultLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }else {
                cell.resultLabel.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.1083222023, blue: 0, alpha: 1)
                cell.resultLabel.text = "\(wrong):\(cell.resultLabel.text ?? ""),  \(right):\(String(Int(hashviMiPakagcovArjeq(st: cell.actionsLabel.text ?? ""))))"
            }
            return cell
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }
    
    
    
var rowCount = 0
var actionResult = 0
    @IBOutlet var myHistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(rowCount)
        myHistoryTableView.backgroundColor = .gray
        myHistoryTableView.dataSource = self
        myHistoryTableView.delegate = self
        myHistoryTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func hashviMitTvovArmat(st:String) -> Double {
        var arjeq:Double = 0
        let r1 = st.firstIndex(of: "(")
        let r2 = st.lastIndex(of: ")")
        var pakagceriArjeqner = st[r1!..<r2!]
        pakagceriArjeqner.removeFirst()
        arjeq = (Double(pakagceriArjeqner)?.squareRoot())!
        return arjeq
    }
    

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
