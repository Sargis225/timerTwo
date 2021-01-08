//
//  ViewController.swift
//  timerTwo
//
//  Created by Saq on 1/7/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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

