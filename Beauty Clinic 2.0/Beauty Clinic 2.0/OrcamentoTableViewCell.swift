//
//  OrcamentoTableViewCell.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 01/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class OrcamentoTableViewCell: UITableViewCell {
    
    @IBOutlet var labelCodigo: UILabel!
    @IBOutlet var labelStatus: UILabel!
    @IBOutlet var labelData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
