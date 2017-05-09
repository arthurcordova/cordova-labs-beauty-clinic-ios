//
//  NovoAgendamentoDataController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 05/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class NovoAgendamentoDataController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource /*UITableViewDelegate, UITableViewDataSource*/ {
    
    @IBOutlet var pickerData: UIDatePicker!
//    @IBOutlet var tableHorarios: UITableView!
    
    @IBOutlet var collectionHorarios: UICollectionView!
    
    
    var novoAgendamento : NovoAgendamento!
    var horarios: Array<Horario> = []
    var mainController : AgendamentosController!
    var primeiroController : NovoAgendamentoProcedimentoController!
    var teste = ["arthur, aaaa, aaaa, bbb, ccc"]
    
    override func viewDidLoad() {
//        tableHorarios.delegate = self
//        tableHorarios.dataSource = self
//        tableHorarios.separatorStyle = UITableViewCellSeparatorStyle.none
        
        collectionHorarios.delegate = self
        collectionHorarios.dataSource = self
   
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        let date = dateFormatter.string(from: self.pickerData.date)
        var code : NSNumber!
        code = novoAgendamento.produto.codProduto!
        
        
        loadHorarios(codeProc: String(describing: code!), data: date)
        
    }
    
    @IBAction func pickerCahngedAction(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        let date = dateFormatter.string(from: sender.date)
        var code : NSNumber!
        code = novoAgendamento.produto.codProduto!
        
        loadHorarios(codeProc: String(describing: code!), data: date)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return teste.count
        return horarios.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridHorarioItem", for: indexPath) as! HorarioCollectionCellCollectionViewCell
    
        
            cell.labelTime?.text = horarios[indexPath.row].horarioInicial
//        cell.labelTime?.text = teste[indexPath.row]
        
        // Configure the cell
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return horarios.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
//        cell.textLabel?.text = horarios[indexPath.row].horarioInicial
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-M-yyyy"
//        let date = dateFormatter.string(from: self.pickerData.date)
//        
//        self.novoAgendamento.data = date
//        self.novoAgendamento.hora = self.horarios[indexPath.row].horarioInicial
//        self.performSegue(withIdentifier: "segueAgendamentoFinal", sender: self.novoAgendamento)
//        
//    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAgendamentoFinal" {
            let novoAgendamentoConcluir = segue.destination as! NovoAgendamentoConcluirController
            novoAgendamentoConcluir.novoAgendamento = self.novoAgendamento
            novoAgendamentoConcluir.mainController = self.mainController
            novoAgendamentoConcluir.primeiroController = self.primeiroController
            novoAgendamentoConcluir.segundoController = self
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
                    self.collectionHorarios.reloadData()
                }
            }
        }
    }

    
}
