//
//  NovoAgendamentoProcedimentoController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 05/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class NovoAgendamentoProcedimentoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableProdutos: UITableView!
    
    var produtos : Array<Produto> = []
    var novoAgendamento : NovoAgendamento!
    var codCli : NSNumber!
    
    override func viewDidLoad() {
        tableProdutos.delegate = self
        tableProdutos.dataSource = self
        tableProdutos.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableProdutos.register(UITableViewCell.self, forCellReuseIdentifier: "cellProduto")
        let xib = UINib(nibName: "MensagemCellTableViewCell", bundle: nil)
        tableProdutos.register(xib, forCellReuseIdentifier: "cellProduto")
        
        loadProdutos()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MensagemCellTableViewCell = self.tableProdutos.dequeueReusableCell(withIdentifier: "cellProduto") as! MensagemCellTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let produto = produtos[indexPath.row]
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale!
        
        cell.labelTitulo.text = produto.descricao
        cell.labelMensagem.text = formatter.string(from: produto.valorProduto)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.novoAgendamento = NovoAgendamento()
        self.novoAgendamento.codCli = self.codCli
        self.novoAgendamento.produto = self.produtos[indexPath.row]
        self.performSegue(withIdentifier: "segueAgendamentoHorario", sender: self.novoAgendamento)
        
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAgendamentoHorario" {
            let novoAgendamentoData = segue.destination as! NovoAgendamentoDataController
            novoAgendamentoData.novoAgendamento = self.novoAgendamento
        }
    }

    
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadProdutos(){
        WS.jsonToArrayObjects(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/procedimentos/3") { (dic, error) in
            if (error != nil){
                
            } else {
                for dictionary:NSDictionary in dic! {
                    
                    let prod =  Produto(json: dictionary)
                    self.produtos.append(prod)
                    
                }
                OperationQueue.main.addOperation {
                    self.tableProdutos.reloadData()
                }
            }
        }
    }
}
