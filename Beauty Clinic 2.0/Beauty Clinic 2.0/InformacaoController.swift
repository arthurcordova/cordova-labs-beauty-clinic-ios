//
//  InformacaoController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 06/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class InformacaoController: UIViewController {
    
    @IBOutlet var labelVersion: UILabel!
    override func viewDidLoad() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.labelVersion.text = "Versão: " + version
        }
    }
}
