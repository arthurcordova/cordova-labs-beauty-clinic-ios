//
//  ProdutosController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 01/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit

class ProdutosController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    @IBOutlet var tableProdutos: UITableView!
    
    var mainController: PrincipalController?
    var produtos : Array<Produto> = []
    var filteredProducts : Array<Produto> = []
    var pessoa : Pessoa? = nil
    var model: Produto?
    var principalController: PrincipalController?
    var searchController :UISearchController!
    
    override func viewDidLoad() {
        tableProdutos.delegate = self
        tableProdutos.dataSource = self
        tableProdutos.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableProdutos.register(UITableViewCell.self, forCellReuseIdentifier: "cellProduto")
        let xib = UINib(nibName: "MensagemCellTableViewCell", bundle: nil)
        tableProdutos.register(xib, forCellReuseIdentifier: "cellProduto")
        
        loadProdutos()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Pesquisar procedimento..."
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.showsSearchResultsButton = false
        searchController.searchBar.setShowsCancelButton(false, animated: false)
        
        
        definesPresentationContext = true
        tableProdutos.tableHeaderView = searchController.searchBar
        
    }

    func didPresentSearchController(searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredProducts = self.produtos.filter { p in
            return p.descricao.lowercased().contains(searchText.lowercased())
        }
        tableProdutos.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredProducts.count
        }
        return produtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MensagemCellTableViewCell = self.tableProdutos.dequeueReusableCell(withIdentifier: "cellProduto") as! MensagemCellTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let prod : Produto
        if searchController.isActive && searchController.searchBar.text != "" {
            prod = filteredProducts[indexPath.row]
        } else {
            prod = produtos[indexPath.row]
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale!
        
        cell.labelTitulo.text = prod.descricao
        cell.labelMensagem.text = formatter.string(from: prod.valorProduto)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var pro: Produto!
        
        if searchController.isActive {
            pro = filteredProducts[indexPath.row]
            searchController.isActive = false
        } else {
            pro = produtos[indexPath.row]
        }
        
        OperationQueue.main.addOperation {
            let addAlerta = UIAlertController(title: "Carrinho", message: "Deseja adicionar o item \(pro.descricao!) ao carrinho ?", preferredStyle: UIAlertControllerStyle.alert)
            
            addAlerta.addAction(UIAlertAction(title: "Sim", style: .default, handler: { (action: UIAlertAction!) in
                self.principalController?.produtosCarrinho.append(pro)
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
