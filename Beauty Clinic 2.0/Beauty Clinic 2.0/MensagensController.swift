//
//  MensagensController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 26/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class MensagensController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableMensagens: UITableView!
    @IBOutlet var buttonFiltro: UIButton!
    @IBOutlet var buttonEdit: UIBarButtonItem!
    
    var mensagens : Array<Mensagem> = []
    var pessoa : Pessoa? = nil
    var model: Mensagem?
    
    override func viewDidLoad() {
        tableMensagens.delegate = self
        tableMensagens.dataSource = self
        tableMensagens.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableMensagens.register(UITableViewCell.self, forCellReuseIdentifier: "cellMensagem")
        let xib = UINib(nibName: "MensagemCellTableViewCell", bundle: nil)
        tableMensagens.register(xib, forCellReuseIdentifier: "cellMensagem")
        
        loadMensagens()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mensagens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MensagemCellTableViewCell = self.tableMensagens.dequeueReusableCell(withIdentifier: "cellMensagem") as! MensagemCellTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.labelTitulo.text = mensagens[indexPath.row].titulo
        cell.labelMensagem.text = mensagens[indexPath.row].mensagem
        
        
        //        cell.appointmentDay.text  = appintmentsList[indexPath.row]
        //        setupAppointmentsViews(stack: cell.appointStackView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            WS.deleteMensagem(id: self.mensagens[indexPath.row].id)
            self.mensagens.remove(at: indexPath.row)
            self.tableMensagens.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.model = self.mensagens[indexPath.row]
        self.performSegue(withIdentifier: "segueDetalheMensagem", sender: self.model)
        
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueDetalheMensagem" {
            let detalheMensagem = segue.destination as! DetalheMensagemController
            detalheMensagem.mensagem = self.model
        }
    }
    
    @IBAction func editTableAction(_ sender: UIBarButtonItem) {
        if(self.tableMensagens.isEditing == true)
        {
            self.tableMensagens.isEditing = false
            self.buttonEdit.title = "Editar"
        }
        else
        {
            self.buttonEdit.title = "Concluído"
            self.tableMensagens.isEditing = true
            
        }
        
    }
    
    func loadMensagens(){
        
        let code = String(describing: pessoa!.code)
        WS.jsonToArrayObjects(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/msgsporcliente/\(code)") { (dic, error) in
            if (error != nil){
                
            } else {
                for dictionary:NSDictionary in dic! {
                    
                    let msg =  Mensagem(json: dictionary)
                    self.mensagens.append(msg)
                    print(msg.titulo)
                    
                }
                OperationQueue.main.addOperation {
                    self.tableMensagens.reloadData()
                    
                }
                
            }
        }
        
    }
    
    
}
