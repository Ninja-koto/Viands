//
//  MiscTableViewCell.swift
//  AutoLayout
//
//  Created by Saahil Chhabria on 18/08/15.
//  Copyright (c) 2015 Saahil Chhabria. All rights reserved.
//

import UIKit

class MiscTableViewCell: UITableViewCell {

    @IBOutlet weak var miscPrice: UILabel!
    @IBOutlet weak var miscImage: UIImageView!
    @IBOutlet weak var miscName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
