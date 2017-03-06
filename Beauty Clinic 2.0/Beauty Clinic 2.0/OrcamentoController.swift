//
//  OrcamentoController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 01/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class OrcamentoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableOrcamentos: UITableView!
    
    var orcamentos : Array<Orcamento> = []
    var pessoa : Pessoa? = nil
    var model: Orcamento?
    
    override func viewDidLoad() {
        tableOrcamentos.delegate = self
        tableOrcamentos.dataSource = self
        tableOrcamentos.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableOrcamentos.register(UITableViewCell.self, forCellReuseIdentifier: "cellOrcamento")
        let xib = UINib(nibName: "OrcamentoTableViewCell", bundle: nil)
        tableOrcamentos.register(xib, forCellReuseIdentifier: "cellOrcamento")
        
        loadOrcamentos(index: 0)
    }
    
    @IBAction func controlFilterAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loadOrcamentos(index: 0)
        } else if sender.selectedSegmentIndex == 1 {
            loadOrcamentos(index: 1)
        } else if sender.selectedSegmentIndex == 2 {
            loadOrcamentos(index: 2)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orcamentos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:OrcamentoTableViewCell = self.tableOrcamentos.dequeueReusableCell(withIdentifier: "cellOrcamento") as! OrcamentoTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        var code : NSNumber!
        code = orcamentos[indexPath.row].codOrcamento!
        
        cell.labelCodigo.text = String(describing: code!)
        cell.labelStatus.text = orcamentos[indexPath.row].status
        cell.labelData.text = orcamentos[indexPath.row].dataOrcamento
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.model = self.orcamentos[indexPath.row]
        self.performSegue(withIdentifier: "segueDetalheOrcamento", sender: self.model)
        
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetalheOrcamento" {
            let detalheOrcamento = segue.destination as! DetalheOrcamentoController
            detalheOrcamento.orcamento = self.model
        }
    }

    func loadOrcamentos(index: Int){
        self.orcamentos.removeAll()
        self.tableOrcamentos.reloadData()
        
        let code = String(describing: pessoa!.code)
        WS.jsonToArrayObjects(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/orcporcliente/\(code)") { (dic, error) in
            if (error != nil){
                
            } else {
                for dictionary:NSDictionary in dic! {
                    
                    let orc =  Orcamento(json: dictionary)
                    
                    if index == 1 {
                        if orc.status == "CONFIRMADO" {
                            self.orcamentos.append(orc)
                        }
                    } else if index == 2 {
                        if orc.status == "CANCELADO" {
                            self.orcamentos.append(orc)
                        }
                    } else {
                        self.orcamentos.append(orc)
                    }
                }
                OperationQueue.main.addOperation {
                    self.tableOrcamentos.reloadData()
                    
                }
                
            }
        }
        
    }



}
