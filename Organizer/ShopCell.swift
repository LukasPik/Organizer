//
//  ShopCell.swift
//  Organizer
//
//  Created by Lukasz Pik on 20.10.2017.
//  Copyright © 2017 Łukasz Pik. All rights reserved.
//

import UIKit

class ShopCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var state: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
