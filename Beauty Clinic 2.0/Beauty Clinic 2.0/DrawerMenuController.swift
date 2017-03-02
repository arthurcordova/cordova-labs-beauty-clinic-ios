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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueMensagens" {
            
            if let toViewController = segue.destination as? MensagensController {
                toViewController.pessoa = pessoa
            }
        }
        
        if segue.identifier == "segueOrcamentos" {
            
            if let toViewController = segue.destination as? OrcamentoController {
                toViewController.pessoa = pessoa
            }
        }
    }
    
}
