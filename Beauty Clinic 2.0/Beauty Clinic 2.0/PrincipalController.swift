//
//  PrincipalController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 24/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class PrincipalController: UIViewController  {
    
    var pessoa : Pessoa? = nil
    
    override func viewDidLoad() {
        
//        segueIN
//        
//        prepare(for: "", sender: <#T##Any?#>)
//        
//        performSegue(withIdentifier: "segueDrawer", sender: "Teste")
        
        
      //        self.performSegueWithIdentifier("detailSegue", sender: model)
    }
    
    @IBAction func backToPrincipal(segue:UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueDrawer" {
            
            if let toViewController = segue.destination as? DrawerMenuController {
                toViewController.pessoa = pessoa
            }
        }
    }

    @IBAction func drawerMenu(_ sender: UIBarButtonItem) {
            print("Chama Action")
        
     }
  
}
