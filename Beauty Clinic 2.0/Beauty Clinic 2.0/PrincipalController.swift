//
//  PrincipalController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 24/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit
import CoreData

class PrincipalController: UIViewController  {
    
    @IBOutlet var viewCard1: UIView!
    @IBOutlet var viewCard2: UIView!
    @IBOutlet var viewCard3: UIView!
    @IBOutlet var labelBadge: UILabel!
    @IBOutlet var labelNextProcedure: UILabel!
    @IBOutlet var labelNextTime: UILabel!
    @IBOutlet var labelMessage: UILabel!
    @IBOutlet var labelTxtOrcamento: UILabel!
    
    var pessoa : Pessoa? = nil
    var produtosCarrinho: Array<Produto> = []
    var mensagens : Array<Mensagem> = []
    var orcamentos : Array<Orcamento> = []
    var agendamentos : Array<Agendamento> = []
    var appDelegate : AppDelegate!
    
    override func viewDidLoad() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        labelBadge.layer.cornerRadius = labelBadge.bounds.size.width / 2.0
        labelBadge.layer.borderColor = UIColor.lightGray.cgColor
        labelBadge.layer.borderWidth = CGFloat(0)
        labelBadge.clipsToBounds = true
        
        createCardEffect(view: viewCard1)
        createCardEffect(view: viewCard2)
        createCardEffect(view: viewCard3)
        updateBadge()
        loadAgendamentos()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateBadge()
        loadMensagens(index: 0)
        loadOrcamentos(index: 0)
        loadAgendamentos()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateBadge()
    }
    
    @IBAction func backToPrincipal(segue:UIStoryboardSegue) {
        updateBadge()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueDrawer" {
            
            if let toViewController = segue.destination as? DrawerMenuController {
                toViewController.pessoa = pessoa
                toViewController.principalController = self
            }
        }
        
        if segue.identifier == "segueCarrinho" {
            
            if let toViewController = segue.destination as? CarrinhoController {
                toViewController.produtosCarrinho = self.produtosCarrinho
                toViewController.pessoa = self.pessoa
                toViewController.principalController = self
            }
        }
        
    }
    
    @IBAction func callMensagens(_ sender: Any) {
        let story: UIStoryboard = UIStoryboard(name: "Mensagens", bundle: nil)
        let control = story.instantiateViewController(withIdentifier: "mensagensID") as! MensagensController
        control.pessoa = pessoa
        self.navigationController?.pushViewController(control, animated: true);
    }
    
    @IBAction func callOrcamentos(_ sender: Any) {
        let story: UIStoryboard = UIStoryboard(name: "Orcamentos", bundle: nil)
        let control = story.instantiateViewController(withIdentifier: "orcamentosID") as! OrcamentoController
        control.pessoa = pessoa
        self.navigationController?.pushViewController(control, animated: true);
    }
    
    
    @IBAction func drawerMenu(_ sender: UIBarButtonItem) {
        
        
    }
    
    func createCardEffect(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.2
        view.layer.cornerRadius = 4
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius =  4
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset =  CGSize(width: 2, height: 2)
    }
    
    func updateBadge(){
        
        if #available(iOS 10.0, *) {
            let context = self.appDelegate.persistentContainer.viewContext
            let entityProduct = NSFetchRequest<NSFetchRequestResult>(entityName: "Carrinho")
            var counter = 0
            do {
                counter = try context.count(for: entityProduct)
            } catch {
                print("ERROR counter")
            }
            
            if counter > 0 {
                labelBadge.isHidden = false
                labelBadge.text = String(counter)
            } else {
                labelBadge.isHidden = true
            }
            print("\(counter)")
        } else {
            // Fallback on earlier versions
        }
        
        //        if produtosCarrinho.count > 0 {
        //            labelBadge.isHidden = false
        //            labelBadge.text = String(produtosCarrinho.count)
        //        } else {
        //            labelBadge.isHidden = true
        //        }
    }
    
    func loadMensagens(index: Int){
        self.mensagens.removeAll()
        let code = String(describing: pessoa!.code)
        WS.jsonToArrayObjects(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/msgsporcliente/\(code)") { (dic, error) in
            if (error != nil){
                
            } else {
                
                for dictionary:NSDictionary in dic! {
                    let msg =  Mensagem(json: dictionary)
                    if index == 1 {// Não lidas
                        if msg.visualizada == 0 {
                            self.mensagens.append(msg)
                        }
                    } else if index == 2 {//Lidas
                        if msg.visualizada == 1 {
                            self.mensagens.append(msg)
                        }
                    } else {
                        self.mensagens.append(msg)
                    }
                    print(msg)
                    
                }
                OperationQueue.main.addOperation {
                    self.labelMessage.text = "Você possui " + String(self.mensagens.count) + " mensagens"
                }
            }
        }
    }
    
    func loadAgendamentos(){
        agendamentos.removeAll()
        
        let code = String(describing: pessoa!.code)
        WS.jsonToArrayObjects(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/agendamentos/\(code)") { (dic, error) in
            if (error != nil){
                
            } else {
                for dictionary:NSDictionary in dic! {
                    
                    let age =  Agendamento(json: dictionary)
                    self.agendamentos.append(age)
                    
                }
                if (self.agendamentos.count > 0) {
                    OperationQueue.main.addOperation {
                        let agenda : Agendamento = self.agendamentos.last!
                        self.labelNextProcedure.text = agenda.descProcedimento
                        self.labelNextTime.text = "Data: " + agenda.data + " Horário: " + agenda.horario
                        
                    }
                } else {
                    self.labelNextProcedure.text = "Nenhum agendamento próximo"
                    self.labelNextTime.text = " "
                }
            }
        }
    }

    
    func loadOrcamentos(index: Int){
        self.orcamentos.removeAll()
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
                    self.labelTxtOrcamento.text = "Você possui " + String(self.orcamentos.count) + " orçamentos"
                }
            }
        }
    }
}
