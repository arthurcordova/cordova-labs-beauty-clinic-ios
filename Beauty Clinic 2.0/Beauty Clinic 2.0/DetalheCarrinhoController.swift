//
//  DetalheCarrinhoController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 14/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class DetalheCarrinhoController: UIViewController {
    
    @IBOutlet var labelValor: UILabel!
    @IBOutlet var labelQuantidade: UILabel!
    @IBOutlet var navBar: UINavigationBar!
    
    var groupProd : Produto!
    var controllerCarrinho : CarrinhoController!
    var valor: Int = 0
    
    
    override func viewDidLoad() {
        loadValues(value: groupProd.qtd!)
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        let value = groupProd.qtd + Int(sender.value)
//        if valor > value {
//            controllerCarrinho.produtosCarrinho.removeLast()
//        } else {
//            controllerCarrinho
//        }
        
        loadValues(value: value)
    }
    
    @IBAction func backView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadValues(value: Int){
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale!
        navBar.topItem?.title = groupProd.descricao
        labelValor.text = formatter.string(from: (groupProd.valorProduto))!
        labelQuantidade.text = String(describing: value)
    }
}
