//
//  WS.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 28/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import Foundation

class WS: NSObject {
    
    
    static func getRequestLogin(urlBase:String, user : Usuario, completionHander: @escaping (Dictionary<String,AnyObject>, Error?) -> Void) {
        
        let url     = URL(string: urlBase)
        var request = URLRequest(url:url!)
        
        let params = ["cpfcnpj":user.cpf as AnyObject, "senha":user.senha as AnyObject, "codFilial":3 as AnyObject] as Dictionary<String, AnyObject>
        
        do {
            request.httpMethod = "POST"
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        } catch let error as NSError {
            print("erro ao inicializar json: \(error.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:.allowFragments) as! Dictionary<String,AnyObject>
                    
                    print(jsonResult)
                    
                    completionHander(jsonResult as Dictionary<String,AnyObject >,nil)
                    
                    
                } catch {
                    if let httpResponse = response as? HTTPURLResponse {
                        print(httpResponse.statusCode)
                    }
                }
                
            } else {
                print("Connection Error")
            }
            
        }
        task.resume()
    }
    
    
    static func jsonToArrayObjects (urlBase:String, completionHander: @escaping (Array<NSDictionary>?, Error?) -> Void) {
        
        let url     = URL(string: urlBase)
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:.allowFragments) as! Array<NSDictionary>
                    
                    
                    
                    completionHander(jsonResult as Array<NSDictionary>?,nil)
                    
                    
                } catch {
                    if let httpResponse = response as? HTTPURLResponse {
                        print(httpResponse.statusCode)
                    }
                }
                
            } else {
                print("Connection Error")
            }
            
        }
        task.resume()
    }
}
    
//    class func getMensagens( codCliente: String, callback: @escaping (Array<NSDictionary>, NSError?) -> Void) {
//        
////        let http = URLSession.shared
//        let url=URL(string:"http://www2.beautyclinic.com.br/clinwebservice2/servidor/msgsporcliente/\(codCliente)")
//        let task = URLSession.shared.dataTask(with: URLRequest(url:url!) as URLRequest) { (data, response, error) -> Void in
//            if let urlContent = data {
//                
//                if let urlContent = data {
//                    
//                    do {
//                        
//                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:.allowFragments) as! Array<NSDictionary>
//                        
//                        
//                        completionHander(jsonResult as Array<NSDictionary>?,nil)
//                        
//                        
//                    } catch {
//                        if let httpResponse = response as? HTTPURLResponse {
//                            print(httpResponse.statusCode)
//                        }
//                    }
//                    
//                } else {
//                    print("Connection Error")
//                }
//                
//            }
//        }
//            task.resume()
//                
//                
//            }
//            
//            do {
//                if (data?.count == 0) {
//                    print( "ZERO ")
//                }
//                
//                
//                
//                var mensagens: Array<Mensagem> = []
//                let dict: NSArray = try JSONSerialization.jsonObject(with: data!, options:
//                    JSONSerialization.ReadingOptions.mutableContainers) as! Array<Dictionary<String, AnyObject>> as NSArray
//
//                for obj:AnyObject in dict {
//                    let dict = obj as! NSDictionary
//                    let mensagem = Mensagem()
//                    mensagem.id = dict["id"] as! Int
//                    mensagem.titulo = dict["titulo"] as! String
//                    mensagem.autor = dict["autor"] as! String
//                    mensagem.tipoMensagem = dict["tipoMensagem"] as! String
//                    mensagem.dataEnvio = dict["dataEnvio"] as! String
//                    mensagem.visualizada = dict["visualizada"] as! Bool
//                    mensagem.idMsgCliente = dict["idMsgCliente"] as! Int
//                    mensagem.mensagem = dict["mensagem"] as! String
//                    mensagens.append(mensagem)
//                }
//                
//                return mensagens
//            } catch let error as NSError {
//                print("json error: \(error.localizedDescription)")
//            
//            }
//
//            
//            
//        }
//        task.resume()


    

    
//    static func getFilmes(callback: (mensagens: Array<Mensagem>, error: NSError!) -> Void, codCliente: String) {
//       
//        do {
//            let http = URLSession.shared
//            let task = http.dataTaskWithURL(url!, completionHandler: {
//                (data: NSData?, response: URLResponse?, error: NSError?) -> Void in
//                if (error != nil) {
//                    callback(mensagens:[], error: error)
//                } else {
//                    let mensagens = MensagemService.parserMensagens(data!)
//                    dispatch_sync(dispatch_get_main_queue(), {
//                        callback(mensagens:mensagens, error: nil)
//                    })
//                }
//            })
//            task.resume()
//
//          }
//        catch {
//            
//        }
//    }

    
    
    //            print("Arthur")
    //            let allContactsData = try Data(contentsOf: url!)
    //            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
    //            if let arrJSON = allContacts["filmes"] {
    //                for index in 0...arrJSON.count-1 {
    //
    //                    let aObject = arrJSON[index] as! [String : AnyObject]
    //
    //                    //                    names.append(aObject["name"] as! String)
    //                    //                    contacts.append(aObject["email"] as! String)
    //                    print(aObject["titulo"] as! String)
    //                }
    //            }
    //            //            print(names)
    //            //            print(contacts)
    //
    //            //            self.tableView.reloadData()

    
    
    
    
//    static func getMensagens(urlBase:String, completionHander: @escaping (Dictionary<String,AnyObject>, Error?) -> Void) {
//        
//        let url     = URL(string: urlBase)
//        var request = URLRequest(url:url!)
//        
//        do {
//            request.httpMethod = "GET"
////            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//        } catch let error as NSError {
//            print("erro ao inicializar json: \(error.localizedDescription)")
//        }
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
//            
//            if let urlContent = data {
//                
//                if let httpResponse = response as? HTTPURLResponse {
//                                            print(httpResponse.statusCode)
//                                        }
//
//                
//                let jsonData:NSArray = (NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as? NSArray)!
//                if let arrJSON = allContacts["filmes"] {
//                    for index in 0...arrJSON.count-1 {
//                        
//                        let aObject = arrJSON[index] as! [String : AnyObject]
//                        
//                        //                    names.append(aObject["name"] as! String)
//                        //                    contacts.append(aObject["email"] as! String)
//                        print(aObject["titulo"] as! String)
//                    }
//                }
//
//                
//                
//            } else {
//                print("Connection Error")
//            }
//            
//        }
//       task.resume()
//    }
    
//   }
