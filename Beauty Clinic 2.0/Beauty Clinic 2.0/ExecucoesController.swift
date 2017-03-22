//
//  ExecucoesController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 21/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class ExecucoesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableExecucoes: UITableView!
    
    var execucoes : Array<Execucao> = []
    var pessoa : Pessoa!
    
    override func viewDidLoad() {
        tableExecucoes.delegate = self
        tableExecucoes.dataSource = self
        tableExecucoes.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableExecucoes.register(UITableViewCell.self, forCellReuseIdentifier: "cellExec")
        let xib = UINib(nibName: "MensagemCellTableViewCell", bundle: nil)
        tableExecucoes.register(xib, forCellReuseIdentifier: "cellExec")
        
        loadExecucoes()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return execucoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MensagemCellTableViewCell = self.tableExecucoes.dequeueReusableCell(withIdentifier: "cellExec") as! MensagemCellTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.labelTitulo.text = execucoes[indexPath.row].produto
        cell.labelMensagem.text = execucoes[indexPath.row].executor
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    
    func loadExecucoes(){
//        self.mensagens.removeAll()
//        self.tableMensagens.reloadData()
        
        let code = String(describing: pessoa!.code)
//        WS.jsonToArrayObjects(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/execucoes/\(code)") { (dic, error) in
         WS.jsonToArrayObjects(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/execucoes/3819") { (dic, error) in
            if (error != nil){
                
            } else {
                
                for dictionary:NSDictionary in dic! {
                    let exe =  Execucao(json: dictionary)
                    self.execucoes.append(exe)
                    print(exe)
                    
                }
                OperationQueue.main.addOperation {
                    self.tableExecucoes.reloadData()
                    
                }
            }
        }
    }
    
}
