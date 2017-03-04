//
//  DetalheOrcamentoController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 02/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class DetalheOrcamentoController: UIViewController {
    
    @IBOutlet var labelStatus: UILabel!
    @IBOutlet var labelCode: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelValor: UILabel!
    @IBOutlet var labelDesconto: UILabel!
    @IBOutlet var labelTotal: UILabel!
    
    var orcamento: Orcamento?
    
    override func viewDidLoad() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale!
        var code : NSNumber!
        code = orcamento?.codOrcamento!
        
        labelStatus.text = orcamento!.status
        labelCode.text = String(describing: code!)
        labelDate.text = orcamento!.dataOrcamento
        labelValor.text = formatter.string(from: (orcamento!.valorOrcamento)!)!
        labelDesconto.text = formatter.string(from: (orcamento!.valorDesconto)!)!
        labelTotal.text = formatter.string(from: (orcamento!.valorTotal)!)!
        
    }
    
    @IBAction func backView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
