//
//  NovoAgendamentoConcluirController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 06/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class NovoAgendamentoConcluirController: UIViewController {
    
    @IBOutlet var labelProcedimento: UILabel!
    @IBOutlet var labelDataHorario: UILabel!
    @IBOutlet var labelStatus: UILabel!
    
    var novoAgendamento : NovoAgendamento!
    
    override func viewDidLoad() {
        labelProcedimento.text = novoAgendamento.produto.descricao
        labelDataHorario.text = novoAgendamento.data + " " + novoAgendamento.hora
        labelStatus.text = "PENDENTE"
    }
    
    @IBAction func doneAction(_ sender: Any) {
        
      WS.newScheduling(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/realizaragendamento", novo: novoAgendamento, completionHander: { (httpCode, error) in
            if error != nil {
                print(httpCode)
            } else {
                if httpCode == 2010 {
                    OperationQueue.main.addOperation {
                        let addAlerta = UIAlertController(title: "Agendamento", message: "Agendamento realizado com sucesso!", preferredStyle: UIAlertControllerStyle.alert)
                        
                        addAlerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                           
                            
                            
                        }))
                        self.present(addAlerta, animated: true, completion: nil)
                    }
                    
                } else {
                    OperationQueue.main.addOperation {
                        let addAlerta = UIAlertController(title: "Agendamento", message: "Erro. Não foi possível realizar o agendamento!", preferredStyle: UIAlertControllerStyle.alert)
                        
                        addAlerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                        self.present(addAlerta, animated: true, completion: nil)
                    }
                }
                
//                let pessoa = Pessoa()
//                pessoa.nome = dic["fantasia"] as! String
//                pessoa.cpf = dic["cpfcnpj"] as! String
//                pessoa.code = dic["codcliente"] as! Int
//
//                OperationQueue.main.addOperation {
//                    let mainNavigator = UINavigationController()
//                    
//                    let principal: UIStoryboard = UIStoryboard(name: "Principal", bundle: nil)
//                    let controller = principal.instantiateViewController(withIdentifier: "principalID") as! PrincipalController
//                    controller.pessoa = pessoa
//                    
//                    mainNavigator.setNavigationBarHidden(true, animated: false)
//                    
//                    mainNavigator.pushViewController(controller, animated: true)
//                    
//                    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
//                    appDelegate.window!.rootViewController = mainNavigator
//                    
//                    
//                }
            }
        })

        
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
