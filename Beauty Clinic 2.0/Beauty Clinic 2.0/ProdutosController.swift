//
//  ProdutosController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 01/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class ProdutosController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var buttonSearch: UIBarButtonItem!
    @IBOutlet var tableProdutos: UITableView!
    
    var mainController: PrincipalController?
    var produtos : Array<Produto> = []
    var pessoa : Pessoa? = nil
    var model: Produto?
    var principalController: PrincipalController?
    
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
        
        OperationQueue.main.addOperation {
            let addAlerta = UIAlertController(title: "Carrinho", message: "Deseja adicionar o item \(self.produtos[indexPath.row].descricao!) ao carrinho ?", preferredStyle: UIAlertControllerStyle.alert)
            
            addAlerta.addAction(UIAlertAction(title: "Sim", style: .default, handler: { (action: UIAlertAction!) in
                self.principalController?.produtosCarrinho.append(self.produtos[indexPath.row])
            }))
            
            addAlerta.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
            self.present(addAlerta, animated: true, completion: nil)
            self.tableProdutos.deselectRow(at: indexPath, animated:true)
        }
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
