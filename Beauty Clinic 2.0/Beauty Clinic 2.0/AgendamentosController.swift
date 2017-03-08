//
//  AgendamentosController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 05/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class AgendamentosController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableAgendamentos: UITableView!
    
    var agendamentos : Array<Agendamento> = []
    var pessoa : Pessoa!
    var model: Agendamento!
    
    override func viewDidLoad() {
        tableAgendamentos.delegate = self
        tableAgendamentos.dataSource = self
        tableAgendamentos.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableAgendamentos.register(UITableViewCell.self, forCellReuseIdentifier: "cellAgendamento")
        let xib = UINib(nibName: "AgendamentoTableViewCell", bundle: nil)
        tableAgendamentos.register(xib, forCellReuseIdentifier: "cellAgendamento")
        
        loadAgendamentos()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agendamentos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AgendamentoTableViewCell = self.tableAgendamentos.dequeueReusableCell(withIdentifier: "cellAgendamento") as! AgendamentoTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
//        var code : NSNumber!
//        code = agendamentos[indexPath.row].codAgenda!
        
        cell.labelProcedimento.text = agendamentos[indexPath.row].descProcedimento
        cell.labelStatus.text = agendamentos[indexPath.row].status
        cell.labelDataHorario.text = agendamentos[indexPath.row].data + " " + agendamentos[indexPath.row].horario
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.model = self.agendamentos[indexPath.row]
        self.performSegue(withIdentifier: "segueDetalheAgendamento", sender: self.model)
        
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetalheAgendamento" {
            let detalheAgendamento = segue.destination as! DetalheAgendamentoController
            detalheAgendamento.agendamento = self.model
        }
        if segue.identifier == "segueNovoAgendamento" {
            let novoAgendamento = segue.destination as! NovoAgendamentoProcedimentoController
            novoAgendamento.codCli = self.pessoa?.code as NSNumber!
            novoAgendamento.mainController = self
        }
    }
    
    func loadAgendamentos(){
        
        let code = String(describing: pessoa!.code)
        WS.jsonToArrayObjects(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/agendamentos/\(code)") { (dic, error) in
            if (error != nil){
                
            } else {
                for dictionary:NSDictionary in dic! {
                    
                    let age =  Agendamento(json: dictionary)
                    self.agendamentos.append(age)
                    
                }
                OperationQueue.main.addOperation {
                    self.tableAgendamentos.reloadData()
                    
                }
                
            }
        }
        
    }

    
    
}
