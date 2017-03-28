//
//  DetalheCarrinhoController.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 14/03/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import UIKit
import CoreData

class DetalheCarrinhoController: UIViewController {
    
    @IBOutlet var labelValor: UILabel!
    @IBOutlet var labelQuantidade: UILabel!
    @IBOutlet var navBar: UINavigationBar!
    
    var groupProd : Produto!
    var controllerCarrinho : CarrinhoController!
    var valor: Int = 0
    var appDelegate : AppDelegate!
    var somador: Int = 0
    var valorUnit: NSNumber!
    var valorTotal: NSNumber!
    
    
    override func viewDidLoad() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        valorUnit = groupProd.valorProduto.floatValue / Float(groupProd.qtd) as! NSNumber
        valorTotal = groupProd.valorProduto
        
        loadValues(value: groupProd.qtd!)
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        
        let value = groupProd.qtd + Int(sender.value)
        if (somador > value) {
            print("Menos")
//            if #available(iOS 10.0, *) {
//                let context = self.appDelegate.persistentContainer.viewContext
//                let entity = NSEntityDescription.insertNewObject(forEntityName: "Carrinho", into: context)
//                entity.setValue(self.groupProd.codProduto.description, forKey: "id")
//                entity.setValue(self.groupProd.descricao, forKey: "desc")
//                entity.setValue(self.valorUnit.description, forKey: "value")
//                entity.setValue(self.groupProd.tipoExame.description, forKey: "type")
//                entity.setValue("1", forKey: "qtd")
//                
//                do {
//                    try context.delete(<#T##object: NSManagedObject##NSManagedObject#>)()
//                    print("Saved")
//                    valorTotal = valorTotal.floatValue + valorUnit.floatValue as NSNumber
//                    
//                } catch {
//                    print("ERROR Saved")
//                }
//            } else {
//                // Fallback on earlier versions
//            }
            valorTotal = valorTotal.floatValue + valorUnit.floatValue as NSNumber
            loadValues(value: value)

        } else {
            print("Mais")
            if #available(iOS 10.0, *) {
                let context = self.appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.insertNewObject(forEntityName: "Carrinho", into: context)
                entity.setValue(self.groupProd.codProduto.description, forKey: "id")
                entity.setValue(self.groupProd.descricao, forKey: "desc")
                entity.setValue(self.valorUnit.description, forKey: "value")
                entity.setValue(self.groupProd.tipoExame.description, forKey: "type")
                entity.setValue("1", forKey: "qtd")
                
                do {
                    try context.save()
                    print("Saved")
                    valorTotal = valorTotal.floatValue + valorUnit.floatValue as NSNumber
                    
                } catch {
                    print("ERROR Saved")
                }
            } else {
                // Fallback on earlier versions
            }
            loadValues(value: value)

        }
        loadValues(value: value)
    }
    
    @IBAction func backView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadValues(value: Int){
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale!
        navBar.topItem?.title = groupProd.descricao
        labelValor.text = formatter.string(from: (valorTotal))!
        labelQuantidade.text = String(describing: value)
        somador = value
    }
}
