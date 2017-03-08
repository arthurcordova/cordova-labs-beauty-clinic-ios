//
//  NovoAgendamentoDataController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 05/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class NovoAgendamentoDataController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var pickerData: UIDatePicker!
    @IBOutlet var tableHorarios: UITableView!
    
    var novoAgendamento : NovoAgendamento!
    var horarios: Array<Horario> = []
    var mainController : AgendamentosController!
    
    override func viewDidLoad() {
        tableHorarios.delegate = self
        tableHorarios.dataSource = self
        tableHorarios.separatorStyle = UITableViewCellSeparatorStyle.none
   
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        let date = dateFormatter.string(from: self.pickerData.date)
        var code : NSNumber!
        code = novoAgendamento.produto.codProduto!
        
        
        loadHorarios(codeProc: String(describing: code!), data: date)
        
    }
    
    @IBAction func pickerCahngedAction(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        let date = dateFormatter.string(from: sender.date)
        var code : NSNumber!
        code = novoAgendamento.produto.codProduto!
        
        loadHorarios(codeProc: String(describing: code!), data: date)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return horarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = horarios[indexPath.row].horarioInicial
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        let date = dateFormatter.string(from: self.pickerData.date)
        
        self.novoAgendamento.data = date
        self.novoAgendamento.hora = self.horarios[indexPath.row].horarioInicial
        self.performSegue(withIdentifier: "segueAgendamentoFinal", sender: self.novoAgendamento)
        
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAgendamentoFinal" {
            let novoAgendamentoConcluir = segue.destination as! NovoAgendamentoConcluirController
            novoAgendamentoConcluir.novoAgendamento = self.novoAgendamento
            novoAgendamentoConcluir.mainController = self.mainController
        }
    }
   
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadHorarios(codeProc: String, data: String){
        let url =  "http://www2.beautyclinic.com.br/clinwebservice2/servidor/horarios/3/" + codeProc + "/" + data.replacingOccurrences(of: "/", with: "-")
        
        WS.jsonToArrayObjects(urlBase: url ) { (dic, error) in
            if (error != nil){
                
            } else {
                for dictionary:NSDictionary in dic! {
                    
                    let hora =  Horario(json: dictionary)
                    self.horarios.append(hora)
                    
                }
                OperationQueue.main.addOperation {
                    self.tableHorarios.reloadData()
                }
            }
        }
    }

    
}
