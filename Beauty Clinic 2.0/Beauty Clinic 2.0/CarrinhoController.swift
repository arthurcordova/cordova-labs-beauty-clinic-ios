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
    var groupProducts: Array<Produto> = []
    var pessoa : Pessoa!
    var totalValue: NSNumber!
    var principalController: PrincipalController!
    var productSelected : Produto!
    
    override func viewDidLoad() {
        tableCarrinho.delegate = self
        tableCarrinho.dataSource = self
        tableCarrinho.separatorStyle = UITableViewCellSeparatorStyle.none
        
        groupProducts.removeAll()
        
        self.loadTotal()
        self.group()
//        var sum :Float = 0
//        var count :Int = 0
//        var position : Int = 0
//        var newProd : Produto!
//        var contains = false
//        for prod : Produto in produtosCarrinho {
//            
//            sum = 0
//            count = 0
//            for var i in 0..<produtosCarrinho.count {
//                if (prod.codProduto == produtosCarrinho[i].codProduto){
//                    sum += produtosCarrinho[i].valorProduto as Float!
//                    count += 1
//                }
//            }
//            
//            
//            for var i in 0..<groupProducts.count {
//                if (prod.codProduto == groupProducts[i].codProduto){
//                    contains = true
//                    position = i
//                    break
//                }
//            }
//            
//            if (!contains){
//                newProd = Produto()
//                newProd.codProduto = prod.codProduto
//                newProd.descricao = prod.descricao
//                newProd.tipoExame = prod.tipoExame
//                newProd.valorProduto = sum as NSNumber!
//                newProd.qtd = count
//                groupProducts.append(newProd)
//            } else {
////                groupProducts.remove(at: position)
//                groupProducts[position].valorProduto = sum as NSNumber!
//                groupProducts[position].qtd = count
//            }
//            contains = false
//        }
//        sum = 0
        tableCarrinho.register(UITableViewCell.self, forCellReuseIdentifier: "cellCarrinho")
        let xib = UINib(nibName: "MensagemCellTableViewCell", bundle: nil)
        tableCarrinho.register(xib, forCellReuseIdentifier: "cellCarrinho")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MensagemCellTableViewCell = self.tableCarrinho.dequeueReusableCell(withIdentifier: "cellCarrinho") as! MensagemCellTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let produto = groupProducts[indexPath.row]
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale!
        
        cell.labelTitulo.text = produto.descricao
        cell.labelMensagem.text = formatter.string(from: (produto.valorProduto)!)!
        cell.labelQtd.text = "Quantidade: " + String(produto.qtd!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.productSelected = self.groupProducts[indexPath.row]
        self.performSegue(withIdentifier: "segueTeste", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueTeste" {
            let detail = segue.destination as! DetalheCarrinhoController
            detail.groupProd = self.productSelected
            detail.controllerCarrinho = self
        }
        
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            var indexes : Array<Int> = [];
            let prod : Produto = groupProducts[indexPath.row]
            
            for var x in 0..<self.produtosCarrinho.count {
                if (prod.codProduto == self.produtosCarrinho[x].codProduto){
                    indexes.append(x)
                }
            }
//            for ind : Int in indexes {
//                self.produtosCarrinho.remove(at: ind)
//            }
//
//            indexes.removeAll()
//            for var x in 0..<self.principalController.produtosCarrinho.count {
//                if (prod.codProduto == self.principalController.produtosCarrinho[x].codProduto){
//                    indexes.append(x)
//                }
//            }
//            for ind : Int in indexes {
//                self.principalController.produtosCarrinho.remove(at: ind)
//            }

            self.groupProducts.remove(at: indexPath.row)
            
            
//            self.produtosCarrinho.remove(at: indexPath.row)
//            self.principalController.produtosCarrinho.remove(at: indexPath.row)
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
                        
//                        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
//                        
//                        let viewController = UIStoryboard(name: "Principal", bundle: nil).instantiateViewController(withIdentifier: "principalID") as! PrincipalController
//                        
//                        viewController.pessoa = self.principalController.pessoa
//                        viewController.produtosCarrinho = self.principalController.produtosCarrinho
//                        
//                        appDelegate.window?.rootViewController = viewController
//                        appDelegate.window?.makeKeyAndVisible()
                        self.dismiss(animated: true, completion: nil)
                        
                    }))
                    self.present(addAlerta, animated: true, completion: nil)
                    
                    
                    
                }
            }
        })
        
    }
    
    @IBAction func backView(_ sender: UIBarButtonItem) {
        self.groupProducts.removeAll()
        self.produtosCarrinho.removeAll()
        self.dismiss(animated: true, completion: nil)
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
    
    func group(){
        var sum :Float = 0
        var count :Int = 0
        var position : Int = 0
        var newProd : Produto!
        var contains = false
        for prod : Produto in produtosCarrinho {
            
            sum = 0
            count = 0
            for var i in 0..<produtosCarrinho.count {
                if (prod.codProduto == produtosCarrinho[i].codProduto){
                    sum += produtosCarrinho[i].valorProduto as Float!
                    count += 1
                }
            }
            
            
            for var i in 0..<groupProducts.count {
                if (prod.codProduto == groupProducts[i].codProduto){
                    contains = true
                    position = i
                    break
                }
            }
            
            if (!contains){
                newProd = Produto()
                newProd.codProduto = prod.codProduto
                newProd.descricao = prod.descricao
                newProd.tipoExame = prod.tipoExame
                newProd.valorProduto = sum as NSNumber!
                newProd.qtd = count
                groupProducts.append(newProd)
            } else {
                //                groupProducts.remove(at: position)
                groupProducts[position].valorProduto = sum as NSNumber!
                groupProducts[position].qtd = count
            }
            contains = false
        }
        sum = 0
    }
}
