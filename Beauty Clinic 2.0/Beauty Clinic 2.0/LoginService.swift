//
//  LoginService.swift
//  Beauty Clinic 2.0
//
//  Created by Arthur on 24/02/17.
//  Copyright © 2017 Cordova labs. All rights reserved.
//

import Foundation

class LoginService: ServiceConfig {
    
    func doLogin(usuario: Usuario, completionHander: @escaping (Dictionary<String,AnyObject>, Error?) -> Void) {
        
        var request = URLRequest(url: URL(string: server.appending("/login"))!)
        request.httpMethod = "POST"
        let postString = "codFilial=\(usuario.filial)" +
            "&cpfcnpj=\(usuario.cpf)" +
            "&senha=\(usuario.senha)"
        request.httpBody = postString.data(using: .utf8)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

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

   
//        
//            do {
//                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
//                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//                request.addValue("application/json", forHTTPHeaderField: "Accept")
//            } catch let error as NSError {
//                print("erro ao inicializar json: \(error.localizedDescription)")
//            }
//            
//            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
//                data, response, error in
//                
//                do {
//                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
//                    
//                    let defaults = NSUserDefaults.standardUserDefaults()
//                    
//                    if let parseJSON = json {
//                        let cliente = Cliente()
//                        cliente.codCliente = parseJSON["codcliente"] as! Int
//                        cliente.cpfcnpj = parseJSON["cpfcnpj"] as! String
//                        cliente.nome = parseJSON["nome"] as! String
//                        cliente.sexo = parseJSON["senha"] as! String
//                        //let jsonStatus: NSDictionary = parseJSON["status"] as! NSDictionary
//                        //cliente.agendamentos = jsonStatus["agendamentos"] as! Int
//                        //cliente.mensagens = jsonStatus["mensagens"] as! Int
//                        
//                        defaults.setInteger(cliente.codCliente, forKey: "codigo")
//                        defaults.setObject(cliente.cpfcnpj, forKey: "cnpj")
//                        defaults.setObject(cliente.nome, forKey: "nome")
//                        defaults.synchronize()
//                        
//                        completion(cliente)
//                    }
//                    
//                } catch let error as NSError {
//                    print("erro ao inicializar json: \(error.localizedDescription)")
//                    let cliente = Cliente()
//                    cliente.codCliente = 0
//                    cliente.cpfcnpj = "0"
//                    cliente.nome = "Erro"
//                    cliente.sexo = "F"
//                    completion(cliente)
//                }
//            }
//            task.resume()
//        }
        
//    }

    
}
