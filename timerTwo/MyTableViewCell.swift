//
//  MyTableViewCell.swift
//  timerTwo
//
//  Created by Saq on 1/7/21.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var equalImage: UIImageView!
    @IBOutlet var actionIndexLabel: UILabel!
    
    @IBOutlet var actionsLabel: UILabel!
    
    @IBOutlet var resultLabel: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
