//
//  TableViewCell.swift
//  PortalCodeApp
//
//  Created by Arif Demirkoparan on 26.01.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var oneLbl: UILabel!
    @IBOutlet weak var twoLbl: UILabel!
    @IBOutlet weak var threeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
