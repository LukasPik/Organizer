//
//  HoursCell.swift
//  Organizer
//
//  Created by Lukasz Pik on 21.10.2017.
//  Copyright © 2017 Łukasz Pik. All rights reserved.
//

import UIKit

class HoursCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
