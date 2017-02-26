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
    
    var list : Array<String> = ["Tuesday","Monday", "Saturday"]
    var mensagens : Array<Mensagem> = []
    
    override func viewDidLoad() {
        tableMensagens.delegate = self
        tableMensagens.dataSource = self
        tableMensagens.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableMensagens.register(UITableViewCell.self, forCellReuseIdentifier: "cellMensagem")
        let xib = UINib(nibName: "MensagemCellTableViewCell", bundle: nil)
        tableMensagens.register(xib, forCellReuseIdentifier: "cellMensagem")

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MensagemCellTableViewCell = self.tableMensagens.dequeueReusableCell(withIdentifier: "cellMensagem") as! MensagemCellTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.labelTitulo.text = "TEste"
        cell.labelMensagem.text = "Mensagem teste do app"
        
        
//        cell.appointmentDay.text  = appintmentsList[indexPath.row]
//        setupAppointmentsViews(stack: cell.appointStackView)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              
    }
    
    func loadMensagens(){
//        let http = NSURLSession.sharedSession()
//        let url = NSURL(string: "http://www2.beautyclinic.com.br/clinwebservice2/servidor/msgsporcliente/" + "\(codCliente)")!
//        let task = http.dataTaskWithURL(url, completionHandler: {
//            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
//            if (error != nil) {
//                callback(mensagens:[], error: error)
//            } else {
//                let mensagens = MensagemService.parserMensagens(data!)
//                dispatch_sync(dispatch_get_main_queue(), {
//                    callback(mensagens:mensagens, error: nil)
//                })
//            }
//        })
//
//        
//        
//        
//        let url=URL(string:"http://www.mocky.io/v2/58559bcb2c00004d1d598d5b")
//        do {
//            print("Arthur")
//            let allContactsData = try Data(contentsOf: url!)
//            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
//            if let arrJSON = allContacts["filmes"] {
//                for index in 0...arrJSON.count-1 {
//                    
//                    let aObject = arrJSON[index] as! [String : AnyObject]
//                    
//                    let f = Filme()
//                    f.titulo = aObject["titulo"] as! String
//                    f.subTitulo = aObject["subtitulo"] as! String
//                    f.duracao = aObject["duracao"] as! String
//                    f.sinopse = aObject["sinopse"] as! String
//                    filmes.append(f)
//                }
//            }
//        }
//        catch {
//            
//        }

    }

    
}
