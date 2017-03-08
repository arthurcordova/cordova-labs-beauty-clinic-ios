//
//  CarrinhoController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 03/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class CarrinhoController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var labelTotal: UILabel!
    @IBOutlet var tableCarrinho: UITableView!
    @IBOutlet var buttonFinalizar: UIBarButtonItem!
    
    var produtosCarrinho: Array<Produto> = []
    var pessoa : Pessoa!
    var totalValue: NSNumber!
    var principalController: PrincipalController!
    
    override func viewDidLoad() {
        tableCarrinho.delegate = self
        tableCarrinho.dataSource = self
        tableCarrinho.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableCarrinho.register(UITableViewCell.self, forCellReuseIdentifier: "cellCarrinho")
        let xib = UINib(nibName: "MensagemCellTableViewCell", bundle: nil)
        tableCarrinho.register(xib, forCellReuseIdentifier: "cellCarrinho")
        
        self.loadTotal()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtosCarrinho.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell:MensagemCellTableViewCell = self.tableCarrinho.dequeueReusableCell(withIdentifier: "cellCarrinho") as! MensagemCellTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let produto = produtosCarrinho[indexPath.row]
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale!
        
        cell.labelTitulo.text = produto.descricao
        cell.labelMensagem.text = formatter.string(from: (produto.valorProduto)!)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        OperationQueue.main.addOperation {
//            let addAlerta = UIAlertController(title: "Carrinho", message: "Deseja adicionar o item \(self.produtos[indexPath.row].descricao!) ao carrinho ?", preferredStyle: UIAlertControllerStyle.alert)
//            
//            addAlerta.addAction(UIAlertAction(title: "Sim", style: .default, handler: { (action: UIAlertAction!) in
//                self.produtosCarrinho.append(self.produtos[indexPath.row])
//            }))
//            
//            addAlerta.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
//            self.present(addAlerta, animated: true, completion: nil)
//            self.produtosCarrinho.deselectRow(at: indexPath, animated:true)
//        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.produtosCarrinho.remove(at: indexPath.row)
            self.principalController.produtosCarrinho.remove(at: indexPath.row)
            self.tableCarrinho.deleteRows(at: [indexPath], with: .automatic)
            OperationQueue.main.addOperation {
                self.loadTotal()
            }
        }
    }
    
    @IBAction func finalizarAction(_ sender: Any) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateFormated = formatter.string(from: date)
        
        WS.newOrcamento(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/cadorcamento", client: self.pessoa.code, date: dateFormated, value: self.totalValue, completionHander: { (codOrc, error) in
            if error != nil {
                print("Erro")
            } else {
                
                for var i in 0..<self.produtosCarrinho.count {
                    WS.newOrcamentoProdutos(urlBase: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/cadprodorcamento/".appending(codOrc), produto: self.produtosCarrinho[i].codProduto as Int, value: self.produtosCarrinho[i].valorProduto,  completionHander: { (httpCode, error) in
                        if error != nil {
                            print("Erro")
                        } else {
                            
                        }
                    })
                }
                OperationQueue.main.addOperation {
                    let addAlerta = UIAlertController(title: "Carrinho", message: "Um novo orçamento foi gerado com sucesso!", preferredStyle: UIAlertControllerStyle.alert)
                    
                    addAlerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        self.produtosCarrinho.removeAll()
                        self.tableCarrinho.reloadData()
                        self.principalController?.produtosCarrinho.removeAll()
                        
                        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                        
                        let viewController = UIStoryboard(name: "Principal", bundle: nil).instantiateViewController(withIdentifier: "principalID") as! PrincipalController
                        
                        viewController.pessoa = self.principalController.pessoa
                        viewController.produtosCarrinho = self.principalController.produtosCarrinho
                        
                        appDelegate.window?.rootViewController = viewController
                        appDelegate.window?.makeKeyAndVisible()
                        
                    }))
                    self.present(addAlerta, animated: true, completion: nil)
                    
                    
                    
                }
            }
        })

    }
    
    func loadTotal(){
       
        var value :Float = 0
        for var i in 0..<produtosCarrinho.count {
            value += produtosCarrinho[i].valorProduto as Float!
        }
        self.totalValue = value as NSNumber!
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale!
        
        let testNSNumber: NSNumber = NSNumber(value: value)
        labelTotal.text = formatter.string(from: (testNSNumber))!
        
        if produtosCarrinho.count > 0 {
            buttonFinalizar.isEnabled = true
        } else {
            buttonFinalizar.isEnabled = false
        }
    }
}
