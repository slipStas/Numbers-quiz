//
//  LeaderBoardTableViewCell.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 08.08.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class LeaderBoardTableViewCell: UITableViewCell {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var trueCount: UILabel!
    @IBOutlet weak var slash: UILabel!
    @IBOutlet weak var falseCount: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.trueCount.textColor = .myGreen
        self.falseCount.textColor = .myRed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    override func prepareForReuse() {
        
        score.text = nil
        trueCount.text = nil
        slash.text = nil
        falseCount.text = nil
        dateLabel.text = nil
    }

}
