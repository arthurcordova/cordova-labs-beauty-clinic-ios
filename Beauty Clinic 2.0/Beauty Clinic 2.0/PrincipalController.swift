//
//  PrincipalController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 24/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class PrincipalController: UIViewController  {
    
    @IBOutlet var viewCard1: UIView!
    @IBOutlet var viewCard2: UIView!
    
    var pessoa : Pessoa? = nil
    var produtosCarrinho: Array<Produto> = []
    
    override func viewDidLoad() {
        createCardEffect(view: viewCard1)
        createCardEffect(view: viewCard2)
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
    
    @IBAction func callMensagens(_ sender: Any) {
        let story: UIStoryboard = UIStoryboard(name: "Mensagens", bundle: nil)
        let control = story.instantiateViewController(withIdentifier: "mensagensID") as! MensagensController
        control.pessoa = pessoa
        self.navigationController?.pushViewController(control, animated: true);
    }
    
    @IBAction func callOrcamentos(_ sender: Any) {
        let story: UIStoryboard = UIStoryboard(name: "Orcamentos", bundle: nil)
        let control = story.instantiateViewController(withIdentifier: "orcamentosID") as! OrcamentoController
        control.pessoa = pessoa
        self.navigationController?.pushViewController(control, animated: true);
    }
    
    
    @IBAction func drawerMenu(_ sender: UIBarButtonItem) {
        
        
    }
    
    func createCardEffect(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.2
        view.layer.cornerRadius = 4
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius =  4
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset =  CGSize(width: 2, height: 2)    }
    
    
}
