//
//  DetalheMensagemController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 01/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class DetalheMensagemController: UIViewController {
    
    @IBOutlet var labelTitulo: UILabel!
    @IBOutlet var labelData: UILabel!
    @IBOutlet var texteViewMensagem: UITextView!
    
    var mensagem: Mensagem?
    
    override func viewDidLoad() {
        labelTitulo.text = mensagem?.titulo
        labelData.text = mensagem?.dataEnvio
        texteViewMensagem.text = mensagem?.mensagem
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
