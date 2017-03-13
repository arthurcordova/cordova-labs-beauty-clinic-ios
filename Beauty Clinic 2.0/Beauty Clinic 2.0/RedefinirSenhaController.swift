//
//  RedefinirSenhaController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 13/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class RedefinirSenhaController: UIViewController {
    
    @IBOutlet var inputEmail: UITextField!
    
    override func viewDidLoad() {
        designTextField(textField: self.inputEmail)
    }
    
    func designTextField(textField: UITextField) {
        textField.borderStyle = .none
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 0.0
    }
    
}
