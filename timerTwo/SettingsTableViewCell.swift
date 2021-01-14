//
//  SettingsTableViewCell.swift
//  timerTwo
//
//  Created by Saq on 1/14/21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    var label:UILabel!
    var slider:UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        var sliderFrameSize = self.frame.size
        sliderFrameSize.width -= 60
        
        slider = UISlider(frame: CGRect(origin: CGPoint.zero, size: sliderFrameSize))
        slider.maximumValue = 100
        slider.minimumValue = 30
        slider.value = 60
        slider.addTarget(self, action: #selector(sliderActionTimeInterval), for: .allEvents)
        self.addSubview(slider)
        label = UILabel(frame: CGRect(x: slider.frame.width + 10, y: slider.frame.origin.y + 10, width: 30, height: 30))
        label.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = String(Int(slider.value))
        self.addSubview(label)
        hideSlider()
    }
    
    func showSlider() {
        slider.isHidden = false
        label.isHidden = false
    }
    func hideSlider() {
        slider.isHidden = true
        label.isHidden = true
    }
    
    
    @objc func sliderActionTimeInterval(_ sender:UISlider) {
        label.text = String(Int(sender.value))
        UserDefaults.standard.set(label.text ?? "",forKey: "timeIntervalKey")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
