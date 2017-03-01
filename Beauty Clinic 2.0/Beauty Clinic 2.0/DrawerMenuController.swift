//
//  DrawerMenuController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 25/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class DrawerMenuController: UIViewController {
    
    @IBOutlet var labelNome: UILabel!
    var pessoa : Pessoa? = nil
    
    override func viewDidLoad() {
        
        labelNome.text = pessoa?.nome
    }
    
}
