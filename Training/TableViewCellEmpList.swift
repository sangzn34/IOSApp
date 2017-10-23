//
//  TableViewCellDate.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 21/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//

import UIKit

class TableViewCellEmpList: UITableViewCell {

    @IBOutlet weak var ldID_EMP: UILabel!
    @IBOutlet weak var lbUSER_NAME: UILabel!
    @IBOutlet weak var lbMorning: UILabel!
    @IBOutlet weak var lbAfternoon: UILabel!
    @IBOutlet weak var lbOT: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
