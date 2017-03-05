//
//  AgendamentoTableViewCell.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 05/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class AgendamentoTableViewCell: UITableViewCell {

    @IBOutlet var labelProcedimento: UILabel!
    @IBOutlet var labelDataHorario: UILabel!
    @IBOutlet var labelStatus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
