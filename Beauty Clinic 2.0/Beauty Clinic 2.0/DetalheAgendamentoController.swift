//
//  DetalheAgendamentoController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 05/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class DetalheAgendamentoController: UIViewController {
    
    @IBOutlet var labelProcedimento: UILabel!
    @IBOutlet var labelData: UILabel!
    @IBOutlet var labelStatus: UILabel!
    @IBOutlet var buttonCancel: UIBarButtonItem!
    
    var agendamento : Agendamento!
    
    override func viewDidLoad() {
        if (agendamento.status == "CANCELADO") {
            buttonCancel.isEnabled = false
        } else {
            buttonCancel.isEnabled = true
        }
        
        labelProcedimento.text = agendamento.descProcedimento
        labelData.text = agendamento.data + " " + agendamento.horario
        labelStatus.text = agendamento.status
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        
    }
}
